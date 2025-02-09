import SwiftUI

struct WindowsOverlayView: View {
    @ObservedObject var space: Space
    let parentSize: CGSize
    let cullingBuffer: CGFloat = 13

    var body: some View {
        let totalOffset = CGPoint(x: -space.cameraCenterX, y: -space.cameraCenterY)

        let halfParentWidth = (parentSize.width / 2) / space.cameraZoom
        let halfParentHeight = (parentSize.height / 2) / space.cameraZoom

        let leftBoundary = space.cameraCenterX - halfParentWidth - cullingBuffer
        let rightBoundary = space.cameraCenterX + halfParentWidth + cullingBuffer
        let topBoundary = space.cameraCenterY - halfParentHeight - cullingBuffer
        let bottomBoundary = space.cameraCenterY + halfParentHeight + cullingBuffer

        return ZStack {
            ForEach($space.windows, id: \.id) { $window in
                if isWithinBounds(window: window, left: leftBoundary, right: rightBoundary, top: topBoundary, bottom: bottomBoundary) {
                    WindowView(window: $window, space: space, parentSize: parentSize)
                } else {
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(x: totalOffset.x + parentSize.width / 2,
                y: totalOffset.y + parentSize.height / 2)
        .scaleEffect(space.cameraZoom)
    }

    private func isWithinBounds(window: Window, left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) -> Bool {
        let windowLeft = window.state.x - window.state.width / 2
        let windowRight = window.state.x + window.state.width / 2
        let windowTop = window.state.y - window.state.height / 2
        let windowBottom = window.state.y + window.state.height / 2

        return !(windowRight < left || windowLeft > right || windowBottom < top || windowTop > bottom)
    }
}
