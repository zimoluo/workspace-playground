import SwiftUI

struct MarkersOverlayView: View {
    @ObservedObject var space: Space
    let parentSize: CGSize
    let cullingBuffer: CGFloat = 12

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
        let hitboxSize = 52 / space.cameraZoom
        let baseSize = 27 / space.cameraZoom
        let iconSize = (17 * pow(marker.zoom, 0.28)) / space.cameraZoom
        let shadowRadius = 13 / space.cameraZoom
        let shadowYOffset = 7 / space.cameraZoom

        ZStack {
            Circle()
                .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1).opacity(0.85))
                .frame(width: baseSize, height: baseSize)
                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 1.2), radius: shadowRadius, y: shadowYOffset)

            Image(systemName: "mappin")
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5).opacity(0.85))
        }
        .frame(width: hitboxSize, height: hitboxSize)
        .contentShape(Circle())
        .hoverEffect(.lift)
        .position(x: marker.x, y: marker.y)
        .onTapGesture {
            withAnimation(.smooth(duration: 0.4)) {
                space.moveCameraToMarker(marker)
            }
        }
    }
}
