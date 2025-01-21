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

    static let dotBaseDistance: CGFloat = 36
    static let dotBaseDiameter: CGFloat = 3

    init(windows: [Window] = [], cameraCenterX: CGFloat = 0, cameraCenterY: CGFloat = 0, cameraZoom: CGFloat = 1) {
        self.id = UUID()
        self.dateCreated = Date()
        self.dateModified = Date()

        self.windows = windows
        self.cameraCenterX = cameraCenterX
        self.cameraCenterY = cameraCenterY
        self.cameraZoom = cameraZoom
    }

    func renderDots(viewSize: CGSize, color: Color = .blue) -> some View {
        let scaledDistance = Space.dotBaseDistance * cameraZoom
        let scaledDotDiameter = Space.dotBaseDiameter * cameraZoom

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

        let dots = (startRow...endRow).flatMap { row in
            (startColumn...endColumn).map { column -> CGPoint in
                CGPoint(
                    x: CGFloat(column) * scaledDistance - cameraCenterX + halfViewWidth,
                    y: CGFloat(row) * scaledDistance - cameraCenterY + halfViewHeight
                )
            }
        }

        return Canvas { context, _ in
            for dot in dots {
                let dotDiameter = scaledDotDiameter
                let dotColor = color.opacity(0.4)

                context.fill(
                    Circle().path(in: CGRect(x: dot.x - dotDiameter / 2, y: dot.y - dotDiameter / 2, width: dotDiameter, height: dotDiameter)),
                    with: .color(dotColor)
                )
            }
        }
    }
}
