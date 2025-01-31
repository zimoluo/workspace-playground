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
        let baseSize = 21 / space.cameraZoom
        let overlaySize = (14 * pow(marker.zoom, 0.25)) / space.cameraZoom
        let shadowRadius = 6 / space.cameraZoom
        let shadowYOffset = 4 / space.cameraZoom

        Canvas { context, _ in
            let fillColor = themeColor(from: theme, for: .secondary, in: colorScheme, level: 1).opacity(0.85)
            let strokeColor = themeColor(from: theme, for: .secondary, in: colorScheme, level: 5).opacity(0.85)

            // Draw main circle
            let mainCircle = Path(ellipseIn: CGRect(x: 0, y: 0, width: baseSize, height: baseSize))
            context.fill(mainCircle, with: .color(fillColor))

            // Draw overlay circle with stroke
            let overlayCircle = Path(ellipseIn: CGRect(x: (baseSize - overlaySize) / 2, y: (baseSize - overlaySize) / 2, width: overlaySize, height: overlaySize))
            context.stroke(overlayCircle, with: .color(strokeColor), lineWidth: 2.2 / space.cameraZoom)
        }
        .frame(width: baseSize, height: baseSize)
        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: shadowRadius, y: shadowYOffset)
        .position(x: marker.x, y: marker.y)
        .onTapGesture {
            withAnimation(.smooth(duration: 0.4)) {
                space.moveCameraToMarker(marker)
            }
        }
    }
}
