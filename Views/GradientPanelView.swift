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
}

struct ConnectPointsPanel: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Namespace private var shapeNamespace

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
            let distance = hypot(point.x - gridPoint.x, point.y - gridPoint.y)
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

    var primaryPointBinding: Binding<CodableUnitPoint> {
        switch theme.mainGradient.type {
        case .linear, .mesh:
            return linearStartBinding
        case .radial:
            return radialCenterBinding
        case .angular:
            return angularCenterBinding
        }
    }

    var secondaryPointBinding: Binding<CodableUnitPoint> {
        switch theme.mainGradient.type {
        case .linear, .mesh:
            return linearEndBinding
        case .radial:
            return radialEdgeBinding
        case .angular:
            return angularCenterBinding
        }
    }

    private let angleHandleRadius: CGFloat = 0.14

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

        let handleX = cx + (radius * cos(radians)) / width
        let handleY = cy + (radius * sin(radians)) / height

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
        .transition(.opacity)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GridBackground(gridPoints: gridPoints, dotSize: 4)
                    .edgesIgnoringSafeArea(.all)

                switch theme.mainGradient.type {
                case .linear, .mesh:
                    linearUI(geometry)
                        .transition(.scale(0, anchor: theme.mainGradient.linearAttributes.startPoint.asUnitPoint).combined(with: .opacity))

                case .radial:
                    radialUI(geometry)
                        .transition(.scale(0, anchor: theme.mainGradient.radialAttributes.center.asUnitPoint).combined(with: .opacity))

                case .angular:
                    angularUI(geometry)
                        .transition(.scale(0, anchor: theme.mainGradient.angularAttributes.center.asUnitPoint).combined(with: .opacity))
                }

                DraggablePoint(
                    point: secondaryPointBinding,
                    size: 24,
                    color: theme.secondary.shadeMap(numShades: 16).shadeMap[4].color
                )
                .animation(.easeInOut, value: theme.mainGradient.type)

                DraggablePoint(
                    point: primaryPointBinding,
                    size: 24,
                    color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color
                )
            }
            .animation(.easeInOut, value: theme.mainGradient.type)
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

        let radiusFraction = hypot(dx, dy)
        let ellipseWidth = radiusFraction * width * 2
        let ellipseHeight = radiusFraction * height * 2

        Ellipse()
            .fill(theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.3))
            .frame(width: ellipseWidth, height: ellipseHeight)
            .position(x: centerPt.x, y: centerPt.y)
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

        angularAngleHandle(geometry)
    }
}
