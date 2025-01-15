import SwiftUI

struct DraggablePoint: View {
    @Binding var point: CodableUnitPoint
    var size: CGFloat = 24
    var color: Color = .blue

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            Circle()
                .fill(color)
                .frame(width: size, height: size)
                .position(x: point.x * width, y: point.y * height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newX = min(max(value.location.x / width, 0), 1)
                            let newY = min(max(value.location.y / height, 0), 1)
                            point.x = Double(newX)
                            point.y = Double(newY)
                        }
                )
        }
    }
}

struct GridBackground: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var gridPoints: [CodableUnitPoint]
    var dotSize: CGFloat = 8

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            ForEach(gridPoints.indices, id: \.self) { index in
                let point = gridPoints[index]

                Circle()
                    .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2).opacity(0.75))
                    .frame(width: dotSize, height: dotSize)
                    .position(x: CGFloat(point.x) * width, y: CGFloat(point.y) * height)
            }
        }
    }

    // Helper function to determine if a point is on the border
    private func isPointOnBorder(_ point: CodableUnitPoint) -> Bool {
        let threshold = 0.01 // Adjust as needed for floating point precision
        return point.x < threshold || point.x > (1.0 - threshold) ||
            point.y < threshold || point.y > (1.0 - threshold)
    }
}

struct ConnectPointsPanel: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    // Grid configuration
    let rows: Int = 7
    let columns: Int = 7
    let snappingThreshold: Double = 0.03

    // Computed grid points for snapping
    var gridPoints: [CodableUnitPoint] {
        var points = [CodableUnitPoint]()
        for row in 0..<rows {
            for column in 0..<columns {
                let x = Double(column) / Double(columns - 1)
                let y = Double(row) / Double(rows - 1)
                points.append(CodableUnitPoint(x: x, y: y))
            }
        }
        return points
    }

    func snapPoint(_ point: CodableUnitPoint) -> CodableUnitPoint {
        var closestPoint: CodableUnitPoint?
        var minDistance = Double.infinity

        for gridPoint in gridPoints {
            let distance = sqrt(pow(point.x - gridPoint.x, 2) + pow(point.y - gridPoint.y, 2))
            if distance < minDistance {
                minDistance = distance
                closestPoint = gridPoint
            }
        }

        if let closest = closestPoint, minDistance < snappingThreshold {
            return closest
        }

        return point
    }

    // MARK: - Linear: Start/End Bindings

    var linearStartBinding: Binding<CodableUnitPoint> {
        Binding(
            get: { theme.mainGradient.linearAttributes.startPoint },
            set: { newValue in
                let snapped = snapPoint(newValue)
                theme.mainGradient.linearAttributes.startPoint = snapped
            }
        )
    }

    var linearEndBinding: Binding<CodableUnitPoint> {
        Binding(
            get: { theme.mainGradient.linearAttributes.endPoint },
            set: { newValue in
                let snapped = snapPoint(newValue)
                theme.mainGradient.linearAttributes.endPoint = snapped
            }
        )
    }

    // MARK: - Radial: Center/Edge Bindings

    var radialCenterBinding: Binding<CodableUnitPoint> {
        Binding(
            get: { theme.mainGradient.radialAttributes.center },
            set: { newValue in
                let snapped = snapPoint(newValue)
                theme.mainGradient.radialAttributes.center = snapped
            }
        )
    }

    var radialEdgeBinding: Binding<CodableUnitPoint> {
        Binding(
            get: { theme.mainGradient.radialAttributes.edgePoint },
            set: { newValue in
                let snapped = snapPoint(newValue)
                theme.mainGradient.radialAttributes.edgePoint = snapped
            }
        )
    }

    // MARK: - Angular: Center + Angle

    //
    // For angular gradients, we let the "center" snap, but the "orbit" point
    // does NOT snap — it just changes the angle by user drag.

    var angularCenterBinding: Binding<CodableUnitPoint> {
        Binding(
            get: { theme.mainGradient.angularAttributes.center },
            set: { newValue in
                // Snap the center
                let snapped = snapPoint(newValue)
                theme.mainGradient.angularAttributes.center = snapped
            }
        )
    }

    /// A constant radius for the orbit handle. Feel free to tweak this.
    private let angleHandleRadius: CGFloat = 0.09

    /// A smaller draggable point that orbits around the center at a fixed radius.
    /// We convert drag positions -> angle in degrees, and store in `angularAttributes.angle`.
    ///
    /// Since the center might move, we rely on geometry to recalculate relative positions.
    @ViewBuilder
    private func angularAngleHandle(_ geometry: GeometryProxy) -> some View {
        let center = theme.mainGradient.angularAttributes.center
        let angleDegrees = theme.mainGradient.angularAttributes.angle.degrees
        let width = geometry.size.width
        let height = geometry.size.height

        // Convert angle to x,y in 0..1 coordinates
        let cx = center.x
        let cy = center.y
        let radius = angleHandleRadius * min(width, height)
        // Convert from degrees to radians
        let radians = angleDegrees * .pi / 180

        // The orbit handle is at center + (cos θ, sin θ) * radius
        let handleX = cx + radius * cos(radians) / width
        let handleY = cy + radius * sin(radians) / height

        DraggablePoint(
            point: .constant(CodableUnitPoint(x: handleX, y: handleY)), // not a binding to theme
            size: 20,
            color: theme.secondary.shadeMap(numShades: 16).shadeMap[4].color
        )
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    let relX = value.location.x / width
                    let relY = value.location.y / height

                    // Vector from center -> new location
                    let dx = relX - cx
                    let dy = relY - cy

                    // Recompute angle in degrees
                    let newAngle = atan2(dy, dx) * 180 / .pi
                    theme.mainGradient.angularAttributes.angle.degrees = newAngle
                }
        )
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Grid background dots
                GridBackground(gridPoints: gridPoints, dotSize: 4)
                    .edgesIgnoringSafeArea(.all)

                switch theme.mainGradient.type {
                case .linear:
                    // 1) Show a line from start to end.
                    // 2) Draggable points for start/end
                    linearUI(geometry)

                case .radial:
                    // 1) Show line from center to edge
                    // 2) Draggable points for center/edge
                    radialUI(geometry)

                case .angular:
                    // 1) Show line from center to orbit handle
                    // 2) Center is draggable (snapped)
                    // 3) Orbit handle is draggable (angle only, no snap)
                    angularUI(geometry)
                }
            }
        }
    }

    // MARK: - Linear Editor

    @ViewBuilder
    private func linearUI(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height

        let p1 = CGPoint(
            x: theme.mainGradient.linearAttributes.startPoint.x * width,
            y: theme.mainGradient.linearAttributes.startPoint.y * height
        )
        let p2 = CGPoint(
            x: theme.mainGradient.linearAttributes.endPoint.x * width,
            y: theme.mainGradient.linearAttributes.endPoint.y * height
        )

        // Optional line
        Path { path in
            path.move(to: p1)
            path.addLine(to: p2)
        }
        .stroke(
            theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.2),
            lineWidth: 24
        )

        // Draggable dots
        DraggablePoint(point: linearStartBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color)
        DraggablePoint(point: linearEndBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[4].color)
    }

    // MARK: - Radial Editor

    @ViewBuilder
    private func radialUI(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height

        // Convert from Unit coords to actual points
        let centerPt = CGPoint(
            x: theme.mainGradient.radialAttributes.center.x * width,
            y: theme.mainGradient.radialAttributes.center.y * height
        )

        // Distance in unit space:
        let dx = theme.mainGradient.radialAttributes.edgePoint.x
            - theme.mainGradient.radialAttributes.center.x
        let dy = theme.mainGradient.radialAttributes.edgePoint.y
            - theme.mainGradient.radialAttributes.center.y
        // This fraction is how far edge is from center in 0..1 coordinates
        let radiusFraction = hypot(dx, dy)

        // Convert that fraction to pixel dimensions for an ellipse
        // (EllipticalGradient in SwiftUI is scaled by width/height)
        let ellipseWidth = radiusFraction * width * 2
        let ellipseHeight = radiusFraction * height * 2

        Ellipse()
            .fill(theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.3))
            .stroke(
                theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.3),
                style: StrokeStyle(lineWidth: 4)
            )
            .frame(width: ellipseWidth, height: ellipseHeight)
            .position(x: centerPt.x, y: centerPt.y)

        // Draggable handles for center/edge
        DraggablePoint(point: radialCenterBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color)
        DraggablePoint(point: radialEdgeBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[4].color)
    }

    // MARK: - Angular Editor

    @ViewBuilder
    private func angularUI(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height

        // Center
        let centerPt = CGPoint(
            x: theme.mainGradient.angularAttributes.center.x * width,
            y: theme.mainGradient.angularAttributes.center.y * height
        )

        // Orbit circle radius in pixels: use the smaller dimension => always a circle
        let orbitPxRadius = angleHandleRadius * min(width, height)

        Circle()
            .stroke(
                theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.3),
                style: StrokeStyle(lineWidth: 8, dash: [15.5, 13])
            )
            .frame(width: orbitPxRadius * 2, height: orbitPxRadius * 2)
            .position(x: centerPt.x, y: centerPt.y)

        // Draggable center (snapped)
        DraggablePoint(
            point: angularCenterBinding,
            color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color
        )

        // Orbit handle (angle) – no snap, smaller handle
        angularAngleHandle(geometry)
    }
}

#Preview {
    ConnectPointsPanel().environment(\.theme, Theme(mainGradient: ColorGradient(type: .angular))).padding(64)
}
