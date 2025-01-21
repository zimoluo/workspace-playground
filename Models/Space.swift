import SwiftData
import SwiftUI

@Model
class Space: ObservableObject {
    @Attribute(.unique) var id: UUID

    var dateCreated: Date
    var dateModified: Date

    var windows: [Window]

    var cameraCenterX: CGFloat
    var cameraCenterY: CGFloat
    var cameraZoom: CGFloat

    init(windows: [Window] = [], cameraCenterX: CGFloat = 0, cameraCenterY: CGFloat = 0, cameraZoom: CGFloat = 1) {
        self.id = UUID()
        self.dateCreated = Date()
        self.dateModified = Date()

        self.windows = windows
        self.cameraCenterX = cameraCenterX
        self.cameraCenterY = cameraCenterY
        self.cameraZoom = cameraZoom
    }

    func renderDots(viewSize: CGSize) -> some View {
        let baseDistance: CGFloat = 64 // Base distance between dots
        let baseDotDiameter: CGFloat = 20 // Standard dot diameter
        let originDotMultiplier: CGFloat = 1.5 // Multiplier for the origin dot size

        // Adjust values based on zoom
        let scaledDistance = baseDistance * cameraZoom
        let scaledDotDiameter = baseDotDiameter * cameraZoom
        let scaledOriginDotDiameter = scaledDotDiameter * originDotMultiplier

        // Calculate the visible area bounds in the logical coordinate system
        let halfViewWidth = viewSize.width / 2
        let halfViewHeight = viewSize.height / 2

        let minX = cameraCenterX - halfViewWidth
        let maxX = cameraCenterX + halfViewWidth
        let minY = cameraCenterY - halfViewHeight
        let maxY = cameraCenterY + halfViewHeight

        // Determine the range of visible grid lines using floor and ceil
        let startColumn = Int(floor(minX / scaledDistance))
        let endColumn = Int(ceil(maxX / scaledDistance))
        let startRow = Int(floor(minY / scaledDistance))
        let endRow = Int(ceil(maxY / scaledDistance))

        return ZStack {
            ForEach(startRow...endRow, id: \.self) { row in
                ForEach(startColumn...endColumn, id: \.self) { [self] column in
                    let dotLogicalX = CGFloat(column) * scaledDistance
                    let dotLogicalY = CGFloat(row) * scaledDistance

                    let dotScreenX = dotLogicalX - cameraCenterX + halfViewWidth
                    let dotScreenY = dotLogicalY - cameraCenterY + halfViewHeight

                    let isOriginPoint = dotLogicalX == 0 && dotLogicalY == 0

                    Circle()
                        .fill(isOriginPoint ? Color.red : Color.blue)
                        .frame(
                            width: isOriginPoint ? scaledOriginDotDiameter : scaledDotDiameter,
                            height: isOriginPoint ? scaledOriginDotDiameter : scaledDotDiameter
                        )
                        .position(x: dotScreenX, y: dotScreenY)
                }
            }
        }
    }
}
