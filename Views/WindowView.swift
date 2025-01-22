import SwiftUI

struct WindowView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var window: Window
    @ObservedObject var space: Space

    let parentSize: CGSize

    @State private var dragOffset: CGSize = .zero

    var body: some View {
        ZStack {
            WindowTypeView(windowData: window.data)
                .frame(width: window.state.width,
                       height: window.state.height)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: window.state.width / 8.33, y: window.state.width / 12.5)
        }
        .position(x: window.state.x + dragOffset.width,
                  y: window.state.y + dragOffset.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if window.id != space.windows.last?.id {
                        space.bringToFront(window)
                    }
                    dragOffset = value.translation
                }
                .onEnded { value in
                    let finalOffset = value.translation
                    window.state.x += finalOffset.width
                    window.state.y += finalOffset.height

                    dragOffset = .zero
                }
        )
        .onTapGesture {
            space.bringToFront(window)
        }
    }
}
