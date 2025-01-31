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

    var showMarkers: Bool
    var markers: [SpaceMarker]

    var disableDots: Bool
    var lockCamera: Bool

    var version: Int

    init(windows: [Window] = [], name: String = "New Space", cameraCenterX: CGFloat = 0, cameraCenterY: CGFloat = 0, cameraZoom: CGFloat = 1, showMarkers: Bool = false, markers: [SpaceMarker] = [], disableDots: Bool = false, lockCamera: Bool = false) {
        self.id = UUID()
        self.dateCreated = Date()
        self.dateModified = Date()
        self.version = 1

        self.name = name
        self.windows = windows
        self.cameraCenterX = cameraCenterX
        self.cameraCenterY = cameraCenterY
        self.cameraZoom = cameraZoom
        self.showMarkers = showMarkers
        self.markers = markers
        self.disableDots = disableDots
        self.lockCamera = lockCamera
    }

    func renderDots(viewSize: CGSize, color: Color) -> some View {
        MetalView(
            color: color,
            viewSize: viewSize,
            cameraCenterX: cameraCenterX,
            cameraCenterY: cameraCenterY,
            cameraZoom: cameraZoom
        )
    }

    func copy() -> Space {
        let copiedWindows = windows.map { window -> Window in
            var newWindow = window
            newWindow.id = UUID()
            return newWindow
        }
        return Space(windows: copiedWindows, name: name, cameraCenterX: cameraCenterX, cameraCenterY: cameraCenterY, cameraZoom: cameraZoom, showMarkers: showMarkers, markers: markers, disableDots: disableDots, lockCamera: lockCamera)
    }

    func updateDateModified() {
        dateModified = Date()
    }

    func bringToFront(_ id: UUID) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            let movedWindow = windows.remove(at: index)
            windows.append(movedWindow)
        }

        updateDateModified()
    }

    func bringToFront(_ window: Window) {
        bringToFront(window.id)
    }

    func removeWindow(_ id: UUID) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            windows.remove(at: index)
        }

        updateDateModified()
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
        updateDateModified()
    }

    func addMarker(_ marker: SpaceMarker) {
        let thresholdX: CGFloat = 0.5
        let thresholdY: CGFloat = 0.5
        let thresholdZoom: CGFloat = 0.01

        for existingMarker in markers {
            if abs(existingMarker.x - marker.x) <= thresholdX &&
                abs(existingMarker.y - marker.y) <= thresholdY &&
                abs(existingMarker.zoom - marker.zoom) <= thresholdZoom
            {
                return
            }
        }

        markers.append(marker)
        showMarkers = true
        updateDateModified()
    }

    func addMarker(x: CGFloat, y: CGFloat, zoom: CGFloat) {
        addMarker(SpaceMarker(x: x, y: y, zoom: zoom))
    }

    func addMarker() {
        addMarker(x: cameraCenterX, y: cameraCenterY, zoom: cameraZoom)
    }

    func removeMarker(_ id: UUID) {
        if let index = markers.firstIndex(where: { $0.id == id }) {
            markers.remove(at: index)
            updateDateModified()
        }
    }

    func removeMarker(_ marker: SpaceMarker) {
        removeMarker(marker.id)
    }

    func moveCameraToMarker(_ marker: SpaceMarker) {
        cameraCenterX = marker.x
        cameraCenterY = marker.y
        cameraZoom = marker.zoom

        updateDateModified()
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

        updateDateModified()
    }

    func thumbnail(canvasSize: CGSize, color: Color = .blue, windowCornerRadius: CGFloat = 4, cameraCenterX: CGFloat? = nil, cameraCenterY: CGFloat? = nil, cameraZoom: CGFloat? = nil) -> some View {
        let zoom = cameraZoom ?? self.cameraZoom
        let cameraCenterX = cameraCenterX ?? self.cameraCenterX
        let cameraCenterY = cameraCenterY ?? self.cameraCenterY

        let dimension: CGFloat = 800
        let scale = canvasSize.width / (dimension / zoom)
        let halfRegionSize = (dimension / 2) / zoom

        let bgColor = color.opacity(0.33)
        let windowColor = color
        let windowCornerRadius: CGFloat = windowCornerRadius

        let regionMinX = cameraCenterX - halfRegionSize
        let regionMinY = cameraCenterY - halfRegionSize

        return Canvas { context, _ in
            context.fill(
                Path(CGRect(origin: .zero, size: canvasSize)),
                with: .color(bgColor)
            )

            let visibleWindows = self.windows.lazy
                .map { window -> (CGRect, CGRect)? in
                    let windowMinX = window.state.x - window.state.width / 2
                    let windowMinY = window.state.y - window.state.height / 2

                    let windowRect = CGRect(
                        x: windowMinX,
                        y: windowMinY,
                        width: window.state.width,
                        height: window.state.height
                    )

                    guard windowRect.maxX >= regionMinX,
                          windowRect.minX <= regionMinX + halfRegionSize * 2,
                          windowRect.maxY >= regionMinY,
                          windowRect.minY <= regionMinY + halfRegionSize * 2
                    else {
                        return nil
                    }

                    let intersection = windowRect.intersection(CGRect(
                        x: regionMinX,
                        y: regionMinY,
                        width: halfRegionSize * 2,
                        height: halfRegionSize * 2
                    ))

                    guard !intersection.isEmpty else { return nil }

                    let scaledRect = CGRect(
                        x: (intersection.origin.x - regionMinX) * scale,
                        y: (intersection.origin.y - regionMinY) * scale,
                        width: intersection.width * scale,
                        height: intersection.height * scale
                    )

                    return (intersection, scaledRect)
                }
                .compactMap { $0 }

            for (_, scaledRect) in visibleWindows {
                context.fill(
                    Path(roundedRect: scaledRect, cornerRadius: windowCornerRadius),
                    with: .color(windowColor)
                )
            }
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
        .clipped()
    }
}

extension CGRect {
    func intersects(with rect: CGRect, gap: CGFloat) -> Bool {
        let expandedSelf = insetBy(dx: -gap / 2, dy: -gap / 2)
        let expandedRect = rect.insetBy(dx: -gap / 2, dy: -gap / 2)
        return expandedSelf.intersects(expandedRect)
    }
}

struct SpaceMarker: Codable {
    var x: CGFloat
    var y: CGFloat
    var zoom: CGFloat
    var id: UUID

    init(x: CGFloat, y: CGFloat, zoom: CGFloat) {
        self.x = x
        self.y = y
        self.zoom = zoom
        self.id = UUID()
    }
}
