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

    init(windows: [Window] = [Window(), Window(data: WindowData(type: .clock)), Window(data: WindowData(type: .clock)), Window(data: WindowData(type: .clock))], cameraCenterX: CGFloat = 0, cameraCenterY: CGFloat = 0, cameraZoom: CGFloat = 1) {
        self.id = UUID()
        self.dateCreated = Date()
        self.dateModified = Date()

        self.windows = windows
        self.cameraCenterX = cameraCenterX
        self.cameraCenterY = cameraCenterY
        self.cameraZoom = cameraZoom
    }

    func renderDots(viewSize: CGSize, color: Color = .blue) -> some View {
        let scaledDotDiameter = Space.dotBaseDiameter * cameraZoom

        let halfViewWidth = viewSize.width / 2
        let halfViewHeight = viewSize.height / 2

        let visibleWidth = viewSize.width / cameraZoom
        let visibleHeight = viewSize.height / cameraZoom

        let minX = cameraCenterX - visibleWidth / 2
        let maxX = cameraCenterX + visibleWidth / 2
        let minY = cameraCenterY - visibleHeight / 2
        let maxY = cameraCenterY + visibleHeight / 2

        let startColumn = Int(floor(minX / Space.dotBaseDistance))
        let endColumn = Int(ceil(maxX / Space.dotBaseDistance))
        let startRow = Int(floor(minY / Space.dotBaseDistance))
        let endRow = Int(ceil(maxY / Space.dotBaseDistance))

        let dots = (startRow ... endRow).flatMap { row in
            (startColumn ... endColumn).map { column -> CGPoint in
                let xRelative = CGFloat(column) * Space.dotBaseDistance - cameraCenterX
                let yRelative = CGFloat(row) * Space.dotBaseDistance - cameraCenterY

                let x = xRelative * cameraZoom + halfViewWidth
                let y = yRelative * cameraZoom + halfViewHeight

                return CGPoint(x: x, y: y)
            }
        }

        return Canvas { context, _ in
            for dot in dots {
                let dotDiameter = scaledDotDiameter.clamped(to: 2.25 ... 4)
                let dotColor = color.opacity(0.4)

                let circle = Path { path in
                    path.addEllipse(in: CGRect(
                        x: dot.x - dotDiameter / 2,
                        y: dot.y - dotDiameter / 2,
                        width: dotDiameter,
                        height: dotDiameter
                    ))
                }

                context.fill(circle, with: .color(dotColor))
            }
        }
    }

    func bringToFront(_ id: UUID) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            let movedWindow = windows.remove(at: index)
            windows.append(movedWindow)
        }
    }

    func bringToFront(_ window: Window) {
        bringToFront(window.id)
    }

    func removeWindow(_ id: UUID) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            windows.remove(at: index)
        }
    }

    func removeWindow(_ window: Window) {
        removeWindow(window.id)
    }
}
