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

    // Currently unused but could be helpful.
    private func isPointOnBorder(_ point: CodableUnitPoint) -> Bool {
        let threshold = 0.01
        return point.x < threshold || point.x > (1.0 - threshold) ||
            point.y < threshold || point.y > (1.0 - threshold)
    }
}

struct ConnectPointsPanel: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    let rows: Int = 7
    let columns: Int = 7
    let snappingThreshold: Double = 0.03

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

    // Angular gradient special
    private let angleHandleRadius: CGFloat = 0.14

    // A special dot
    @ViewBuilder
    private func angularAngleHandle(_ geometry: GeometryProxy) -> some View {
        let center = theme.mainGradient.angularAttributes.center
        let angleDegrees = theme.mainGradient.angularAttributes.angle.degrees
        let width = geometry.size.width
        let height = geometry.size.height

        let cx = center.x
        let cy = center.y
        let radius = angleHandleRadius * min(width, height)

        let radians = angleDegrees * .pi / 180

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

                    let dx = relX - cx
                    let dy = relY - cy

                    let newAngle = atan2(dy, dx) * 180 / .pi
                    theme.mainGradient.angularAttributes.angle.degrees = newAngle
                }
        )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GridBackground(gridPoints: gridPoints, dotSize: 4)
                    .edgesIgnoringSafeArea(.all)

                switch theme.mainGradient.type {
                case .linear, .mesh:
                    linearUI(geometry)

                case .radial:
                    radialUI(geometry)

                case .angular:
                    angularUI(geometry)
                }
            }
        }
    }

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

        Path { path in
            path.move(to: p1)
            path.addLine(to: p2)
        }
        .stroke(
            theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.2),
            lineWidth: 24
        )

        DraggablePoint(point: linearStartBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color)
        DraggablePoint(point: linearEndBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[4].color)
    }

    @ViewBuilder
    private func radialUI(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height

        let centerPt = CGPoint(
            x: theme.mainGradient.radialAttributes.center.x * width,
            y: theme.mainGradient.radialAttributes.center.y * height
        )

        let dx = theme.mainGradient.radialAttributes.edgePoint.x
            - theme.mainGradient.radialAttributes.center.x
        let dy = theme.mainGradient.radialAttributes.edgePoint.y
            - theme.mainGradient.radialAttributes.center.y
        // This fraction is how far edge is from center in 0..1 coordinates
        let radiusFraction = hypot(dx, dy)

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

        DraggablePoint(point: radialCenterBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color)
        DraggablePoint(point: radialEdgeBinding,
                       color: theme.secondary.shadeMap(numShades: 16).shadeMap[4].color)
    }

    @ViewBuilder
    private func angularUI(_ geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height

        let centerPt = CGPoint(
            x: theme.mainGradient.angularAttributes.center.x * width,
            y: theme.mainGradient.angularAttributes.center.y * height
        )

        let orbitPxRadius = angleHandleRadius * min(width, height)

        Circle()
            .stroke(
                theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.3),
                style: StrokeStyle(lineWidth: 6, dash: [10, 10])
            )
            .frame(width: orbitPxRadius * 2, height: orbitPxRadius * 2)
            .position(x: centerPt.x, y: centerPt.y)

        DraggablePoint(
            point: angularCenterBinding,
            color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color
        )

        angularAngleHandle(geometry)
    }
}

#Preview {
    ConnectPointsPanel().environment(\.theme, Theme(mainGradient: ColorGradient(type: .angular))).padding(64)
}
