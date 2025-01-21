import SwiftUI

struct WindowsOverlayView: View {
    @ObservedObject var space: Space
    let parentSize: CGSize

    var body: some View {
        let totalOffset = CGPoint(x: -space.cameraCenterX, y: -space.cameraCenterY)

        return ZStack {
            ForEach($space.windows, id: \.id) { $window in
                WindowView(window: $window, space: space, parentSize: parentSize)
            }
        }
        .offset(x: totalOffset.x + parentSize.width / 2,
                y: totalOffset.y + parentSize.height / 2)
        .scaleEffect(space.cameraZoom)
    }
}
