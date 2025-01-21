import SwiftUI

struct WindowView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var window: Window
    @ObservedObject var space: Space

    var parentSize: CGSize

    // For drag gesture purposes
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        ZStack {
            WindowTypeView(windowData: window.data)
                .frame(width: window.state.width * space.cameraZoom,
                       height: window.state.height * space.cameraZoom)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(6)
                .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
        }
        .position(x: transformedX,
                  y: transformedY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation
                }
                .onEnded { value in
                    let finalOffset = value.translation
                    window.state.x += finalOffset.width / space.cameraZoom
                    window.state.y += finalOffset.height / space.cameraZoom

                    dragOffset = .zero
                }
        )
    }

    private var transformedX: CGFloat {
        let scale = space.cameraZoom
        let halfWidth = parentSize.width / 2

        return ((window.state.x - space.cameraCenterX) + halfWidth) * scale
            + dragOffset.width
    }

    private var transformedY: CGFloat {
        let scale = space.cameraZoom
        let halfHeight = parentSize.height / 2

        return ((window.state.y - space.cameraCenterY) + halfHeight) * scale
            + dragOffset.height
    }
}
