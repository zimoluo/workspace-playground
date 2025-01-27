import SwiftData
import SwiftUI

@Model
class Space: ObservableObject {
    @Attribute(.unique) var id: UUID

    var dateCreated: Date
    var dateModified: Date

    var name: String

    var windows: [Window]

    var cameraCenterX: CGFloat
    var cameraCenterY: CGFloat
    var cameraZoom: CGFloat

    var disableDots: Bool

    static let dotBaseDistance: CGFloat = 36
    static let dotBaseDiameter: CGFloat = 3

    init(windows: [Window] = [], name: String = "New Space", cameraCenterX: CGFloat = 0, cameraCenterY: CGFloat = 0, cameraZoom: CGFloat = 1, disableDots: Bool = false) {
        self.id = UUID()
        self.dateCreated = Date()
        self.dateModified = Date()

        self.name = name
        self.windows = windows
        self.cameraCenterX = cameraCenterX
        self.cameraCenterY = cameraCenterY
        self.cameraZoom = cameraZoom
        self.disableDots = disableDots
    }

    func renderDots(viewSize: CGSize, color: Color = .blue) -> some View {
        let zoom = cameraZoom
        let baseDistance = Space.dotBaseDistance
        let scaledDotDiameter = Space.dotBaseDiameter * zoom

        let metrics = ViewMetrics(
            viewSize: viewSize,
            cameraCenterX: cameraCenterX,
            cameraCenterY: cameraCenterY,
            zoom: zoom,
            baseDistance: baseDistance
        )

        return Canvas { context, _ in
            let dotDiameter = scaledDotDiameter.clamped(to: 2.25 ... 4)
            let dotColor = color.opacity(0.4).cgColor ?? CGColor(gray: 0.0, alpha: 1.0)

            context.withCGContext { cgContext in
                cgContext.setFillColor(dotColor)

                let startRow = metrics.startRow
                let endRow = metrics.endRow
                let startCol = metrics.startColumn
                let endCol = metrics.endColumn

                let halfWidth = metrics.halfViewWidth
                let halfHeight = metrics.halfViewHeight
                let cameraOffsetX = metrics.cameraCenterX * zoom
                let cameraOffsetY = metrics.cameraCenterY * zoom
                let scaledBaseDistance = baseDistance * zoom
                let radius = dotDiameter / 2

                var points = [CGPoint]()
                points.reserveCapacity((endRow - startRow + 1) * (endCol - startCol + 1))

                for row in stride(from: startRow, through: endRow, by: 1) {
                    let baseY = CGFloat(row) * scaledBaseDistance + halfHeight - cameraOffsetY

                    for col in stride(from: startCol, through: endCol, by: 1) {
                        let x = CGFloat(col) * scaledBaseDistance + halfWidth - cameraOffsetX
                        points.append(CGPoint(x: x, y: baseY))
                    }
                }

                points.withUnsafeBufferPointer { buffer in
                    for point in buffer {
                        cgContext.addEllipse(in: CGRect(
                            x: point.x - radius,
                            y: point.y - radius,
                            width: dotDiameter,
                            height: dotDiameter
                        ))
                    }
                }

                cgContext.fillPath()
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

    func addWindow(type: WindowType, x: CGFloat? = nil, y: CGFloat? = nil) {
        let newX = x ?? cameraCenterX
        let newY = y ?? cameraCenterY
        let newWindowState = WindowState(x: newX, y: newY, width: type.defaultSize.width, height: type.defaultSize.height)
        let newWindowData = WindowData.applyDefaults(baseData: WindowData(type: type))
        let newWindow = Window(state: newWindowState, data: newWindowData)
        windows.append(newWindow)
    }

    func clusterWindows() {
        let minGap: CGFloat = 12.0
        let angleIncrement: CGFloat = 0.08
        let spiralSpacing: CGFloat = minGap / 1.5
        let maxSpiralRadius: CGFloat = 10000.0

        let sortedWindowIndices = windows.indices.sorted {
            let windowA = windows[$0]
            let windowB = windows[$1]
            let areaA = windowA.state.width * windowA.state.height
            let areaB = windowB.state.width * windowB.state.height
            return areaA > areaB
        }

        var placedRects: [CGRect] = []

        for index in sortedWindowIndices {
            let window = windows[index]
            var placed = false
            var angle: CGFloat = 0.0
            var radius: CGFloat = 0.0

            while !placed && radius < maxSpiralRadius {
                let x = cameraCenterX + radius * cos(angle)
                let y = cameraCenterY + radius * sin(angle)

                let windowRect = CGRect(
                    x: x - window.state.width / 2,
                    y: y - window.state.height / 2,
                    width: window.state.width,
                    height: window.state.height
                )

                var hasCollision = false
                for placedRect in placedRects {
                    if windowRect.intersects(with: placedRect, gap: minGap) {
                        hasCollision = true
                        break
                    }
                }

                if !hasCollision {
                    windows[index].state.x = x
                    windows[index].state.y = y
                    placedRects.append(windowRect)
                    placed = true
                } else {
                    angle += angleIncrement
                    radius = spiralSpacing * angle / (2 * .pi)
                }
            }
        }
    }
}

extension CGRect {
    func intersects(with rect: CGRect, gap: CGFloat) -> Bool {
        let expandedSelf = insetBy(dx: -gap / 2, dy: -gap / 2)
        let expandedRect = rect.insetBy(dx: -gap / 2, dy: -gap / 2)
        return expandedSelf.intersects(expandedRect)
    }
}

private struct ViewMetrics {
    let halfViewWidth: CGFloat
    let halfViewHeight: CGFloat
    let startRow: Int
    let endRow: Int
    let startColumn: Int
    let endColumn: Int
    let cameraCenterX: CGFloat
    let cameraCenterY: CGFloat

    init(viewSize: CGSize, cameraCenterX: CGFloat, cameraCenterY: CGFloat, zoom: CGFloat, baseDistance: CGFloat) {
        self.halfViewWidth = viewSize.width / 2
        self.halfViewHeight = viewSize.height / 2
        self.cameraCenterX = cameraCenterX
        self.cameraCenterY = cameraCenterY

        let visibleWidth = viewSize.width / zoom
        let visibleHeight = viewSize.height / zoom

        let minX = cameraCenterX - visibleWidth / 2
        let maxX = cameraCenterX + visibleWidth / 2
        let minY = cameraCenterY - visibleHeight / 2
        let maxY = cameraCenterY + visibleHeight / 2

        self.startColumn = Int(floor(minX / baseDistance))
        self.endColumn = Int(ceil(maxX / baseDistance))
        self.startRow = Int(floor(minY / baseDistance))
        self.endRow = Int(ceil(maxY / baseDistance))
    }
}
