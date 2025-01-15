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

// 3. GridBackground View
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

// 4. ConnectPointsPanel View
struct ConnectPointsPanel: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    // Grid configuration
    let rows: Int = 7
    let columns: Int = 7
    let snappingThreshold: Double = 0.03

    // Computed grid points excluding the borders
    var gridPoints: [CodableUnitPoint] {
        var points = [CodableUnitPoint]()
        for row in 0..<rows { // Include first and last rows
            for column in 0..<columns { // Include first and last columns
                let x = Double(column) / Double(columns - 1)
                let y = Double(row) / Double(rows - 1)
                points.append(CodableUnitPoint(x: x, y: y))
            }
        }
        return points
    }

    // Helper function to find the closest grid point within the snapping threshold
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

    // Custom binding for point1 with snapping
    var point1Binding: Binding<CodableUnitPoint> {
        Binding(
            get: { theme.mainGradient.linearAttributes.startPoint },
            set: { newValue in
                let snapped = self.snapPoint(newValue)
                theme.mainGradient.linearAttributes.startPoint = snapped
            }
        )
    }

    // Custom binding for point2 with snapping
    var point2Binding: Binding<CodableUnitPoint> {
        Binding(
            get: { theme.mainGradient.linearAttributes.endPoint },
            set: { newValue in
                let snapped = self.snapPoint(newValue)
                theme.mainGradient.linearAttributes.endPoint = snapped
            }
        )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Grid Background
                GridBackground(gridPoints: gridPoints, dotSize: 4)
                    .edgesIgnoringSafeArea(.all)

                // Line connecting the two points
                Path { path in
                    let p1 = CGPoint(x: theme.mainGradient.linearAttributes.startPoint.x * geometry.size.width, y: theme.mainGradient.linearAttributes.startPoint.y * geometry.size.height)
                    let p2 = CGPoint(x: theme.mainGradient.linearAttributes.endPoint.x * geometry.size.width, y: theme.mainGradient.linearAttributes.endPoint.y * geometry.size.height)
                    path.move(to: p1)
                    path.addLine(to: p2)
                }
                .stroke(theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.2), lineWidth: 24)

                // Draggable Points
                DraggablePoint(point: point1Binding, color: theme.secondary.shadeMap(numShades: 16).shadeMap[10].color)
                DraggablePoint(point: point2Binding, color: theme.secondary.shadeMap(numShades: 16).shadeMap[4].color)
            }
        }
    }
}
