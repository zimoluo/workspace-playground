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

    func renderDots(viewSize: CGSize, dotColor: Color = .blue) -> some View {
        let baseDistance: CGFloat = 36
        let baseDotDiameter: CGFloat = 3
        let originDotMultiplier: CGFloat = 1.25

        let scaledDistance = baseDistance * cameraZoom
        let scaledDotDiameter = baseDotDiameter * cameraZoom
        let scaledOriginDotDiameter = scaledDotDiameter * originDotMultiplier

        let halfViewWidth = viewSize.width / 2
        let halfViewHeight = viewSize.height / 2

        let minX = cameraCenterX - halfViewWidth
        let maxX = cameraCenterX + halfViewWidth
        let minY = cameraCenterY - halfViewHeight
        let maxY = cameraCenterY + halfViewHeight

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
                        .fill(isOriginPoint ? dotColor.opacity(0.25) : dotColor.opacity(0.5))
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
