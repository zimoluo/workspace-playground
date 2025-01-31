import SwiftUI

struct MarkersOverlayView: View {
    @ObservedObject var space: Space
    let parentSize: CGSize
    let cullingBuffer: CGFloat = 10

    var body: some View {
        let totalOffset = CGPoint(x: -space.cameraCenterX, y: -space.cameraCenterY)

        let halfParentWidth = (parentSize.width / 2) / space.cameraZoom
        let halfParentHeight = (parentSize.height / 2) / space.cameraZoom

        let leftBoundary = space.cameraCenterX - halfParentWidth - cullingBuffer
        let rightBoundary = space.cameraCenterX + halfParentWidth + cullingBuffer
        let topBoundary = space.cameraCenterY - halfParentHeight - cullingBuffer
        let bottomBoundary = space.cameraCenterY + halfParentHeight + cullingBuffer

        return ZStack {
            ForEach($space.markers, id: \.id) { $marker in
                if isWithinBounds(marker: marker, left: leftBoundary, right: rightBoundary, top: topBoundary, bottom: bottomBoundary) {
                    MarkerView(marker: $marker, space: space)
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

    private func isWithinBounds(marker: SpaceMarker, left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) -> Bool {
        let markerRadius = 10.5 / space.cameraZoom
        let markerLeft = marker.x - markerRadius
        let markerRight = marker.x + markerRadius
        let markerTop = marker.y - markerRadius
        let markerBottom = marker.y + markerRadius

        return !(markerRight < left || markerLeft > right || markerBottom < top || markerTop > bottom)
    }
}

struct MarkerView: View {
    @Binding var marker: SpaceMarker
    @ObservedObject var space: Space
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        return Circle()
            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1).opacity(0.85))
            .frame(width: 21 / space.cameraZoom, height: 21 / space.cameraZoom)
            .overlay(
                Circle()
                    .stroke(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5).opacity(0.85), lineWidth: 2.2 / space.cameraZoom)
                    .frame(width: 14 / space.cameraZoom * pow(marker.zoom, 0.3), height: 17 / space.cameraZoom * pow(marker.zoom, 0.3))
            )
            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 6 / space.cameraZoom, y: 4 / space.cameraZoom)
            .position(x: marker.x, y: marker.y)
    }
}
