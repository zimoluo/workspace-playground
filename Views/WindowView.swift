import SwiftUI

struct WindowView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var window: Window
    @ObservedObject var space: Space

    let parentSize: CGSize

    @State private var dragOffset: CGSize = .zero
    @State private var resizeOffset: CGSize = .zero

    private var adjustedWidth: CGFloat {
        window.state.width + resizeOffset.width * 2
    }

    private var adjustedHeight: CGFloat {
        window.state.height + resizeOffset.height * 2
    }

    var body: some View {
        ZStack {
            WindowTypeView(windowData: window.data)
                .frame(width: adjustedWidth, height: adjustedHeight)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: adjustedWidth / 8.33, y: adjustedWidth / 12.5)

            Image("WindowHandle")
                .resizable()
                .frame(width: 27, height: 27)
                .offset(x: adjustedWidth / 2 - 6, y: adjustedHeight / 2 - 6)
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2).opacity(0.6))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if window.id != space.windows.last?.id {
                                space.bringToFront(window)
                            }
                            resizeOffset = value.translation
                        }
                        .onEnded { _ in
                            window.state.width = max(100, adjustedWidth)
                            window.state.height = max(100, adjustedHeight)
                            resizeOffset = .zero
                        }
                )
        }
        .position(x: window.state.x + dragOffset.width, y: window.state.y + dragOffset.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if window.id != space.windows.last?.id {
                        space.bringToFront(window)
                    }
                    dragOffset = value.translation
                }
                .onEnded { value in
                    window.state.x += value.translation.width
                    window.state.y += value.translation.height
                    dragOffset = .zero
                }
        )
        .onTapGesture {
            space.bringToFront(window)
        }
    }
}
