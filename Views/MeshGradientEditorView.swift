import SwiftUI

struct MeshGradientEditorView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @State private var selectedVertexIndex: Int = 0

    var body: some View {
        HStack(spacing: 12) {
            meshEditorView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(32)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)

            VStack(spacing: 12) {
                Group {
                    ColorPicker(
                        "Selected vertex color",
                        selection: Binding(
                            get: { selectedVertexColor },
                            set: { newColor in
                                updateSelectedVertexColor(newColor)
                            }
                        ),
                        supportsOpacity: false
                    )
                    .labelsHidden()
                    .scaleEffect(2.4)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)

                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                        .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    HStack(spacing: 12) {
                        VStack(spacing: 8) {
                            Text("ROW").fontWeight(.bold).themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)

                            VerticalSlider(
                                value: Binding(
                                    get: { theme.mainGradient.meshAttributes.height
                                    },
                                    set: { newValue in
                                        updateMeshSize(newWidth: theme.mainGradient.meshAttributes.width, newHeight: newValue)
                                    }
                                )
                            )
                        }

                        VStack(spacing: 8) {
                            Text("COL").fontWeight(.bold).themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)

                            VerticalSlider(
                                value: Binding(
                                    get: { theme.mainGradient.meshAttributes.width
                                    },
                                    set: { newValue in
                                        updateMeshSize(newWidth: newValue, newHeight: theme.mainGradient.meshAttributes.height)
                                    }
                                )
                            )
                        }
                    }
                    .padding(.vertical, 12)
                }
            }
            .frame(width: 120)
        }
        .onAppear {
            if !theme.mainGradient.meshAttributes.points.indices.contains(selectedVertexIndex) {
                selectedVertexIndex = 0
            }
        }
    }

    private var meshEditorView: some View {
        ZStack {
            theme.mainGradient.toGradient(in: colorScheme)
            Rectangle()
                .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .black, location: 0),
                            .init(color: .clear, location: 0.04),
                            .init(color: .clear, location: 0.96),
                            .init(color: .black, location: 1)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            Rectangle()
                .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .black, location: 0),
                            .init(color: .clear, location: 0.04),
                            .init(color: .clear, location: 0.96),
                            .init(color: .black, location: 1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            Rectangle()
                .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .mask(
                    EllipticalGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .clear, location: 0.55),
                            .init(color: .black, location: 0.7)
                        ]),
                        center: .center, startRadiusFraction: 0, endRadiusFraction: 1.08
                    )
                )

            GeometryReader { geo in
                ZStack {
                    meshLines(in: geo.size)
                        .stroke(
                            theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.4),
                            lineWidth: 6
                        )

                    ForEach(cornerIndices, id: \.self) { idx in
                        renderPoint(at: idx, in: geo.size, isCorner: true)
                    }

                    ForEach(nonCornerIndices, id: \.self) { idx in
                        renderPoint(at: idx, in: geo.size)
                    }
                }
            }
        }
    }

    private func renderPoint(at idx: Int, in size: CGSize, isCorner _: Bool = false) -> some View {
        let color = theme.mainGradient.meshAttributes.colors[idx].color
        let isSelected = (idx == selectedVertexIndex)

        let row = idx / theme.mainGradient.meshAttributes.width
        let col = idx % theme.mainGradient.meshAttributes.width
        let isEdge = row == 0 || row == theme.mainGradient.meshAttributes.height - 1 ||
            col == 0 || col == theme.mainGradient.meshAttributes.width - 1
        let isCorner = (row == 0 || row == theme.mainGradient.meshAttributes.height - 1) &&
            (col == 0 || col == theme.mainGradient.meshAttributes.width - 1)

        return ZStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.6), radius: 6, y: 3)
            if isSelected {
                Circle()
                    .strokeBorder(theme.secondary.shadeMap(numShades: 16).shadeMap[8].color.opacity(0.4),
                                  lineWidth: 6)
                    .frame(width: 28, height: 28)
            }
        }
        .position(
            x: CGFloat(theme.mainGradient.meshAttributes.points[idx].x) * size.width,
            y: CGFloat(theme.mainGradient.meshAttributes.points[idx].y) * size.height
        )
        .gesture(
            DragGesture().onChanged { drag in
                if selectedVertexIndex != idx {
                    selectedVertexIndex = idx
                }

                if isCorner { return }

                let newX = min(max(drag.location.x / size.width, 0), 1)
                let newY = min(max(drag.location.y / size.height, 0), 1)

                if !isEdge {
                    theme.mainGradient.meshAttributes.points[idx].x = Float(newX)
                    theme.mainGradient.meshAttributes.points[idx].y = Float(newY)
                    return
                }

                if row == 0 || row == theme.mainGradient.meshAttributes.height - 1 {
                    theme.mainGradient.meshAttributes.points[idx].x = Float(newX)
                    theme.mainGradient.meshAttributes.points[idx].y = row == 0 ? 0.0 : 1.0
                } else if col == 0 || col == theme.mainGradient.meshAttributes.width - 1 {
                    theme.mainGradient.meshAttributes.points[idx].x = col == 0 ? 0.0 : 1.0
                    theme.mainGradient.meshAttributes.points[idx].y = Float(newY)
                }
            }
        )
        .onTapGesture {
            selectedVertexIndex = idx
        }
    }

    private var cornerIndices: [Int] {
        let w = theme.mainGradient.meshAttributes.width
        let h = theme.mainGradient.meshAttributes.height
        let total = w * h
        return [
            0,
            w - 1,
            (h - 1) * w,
            total - 1
        ].filter { $0 >= 0 && $0 < total }
    }

    private var nonCornerIndices: [Int] {
        let w = theme.mainGradient.meshAttributes.width
        let h = theme.mainGradient.meshAttributes.height
        let total = w * h
        return (0..<total).filter { idx in
            let row = idx / w
            let col = idx % w
            let isCorner = (row == 0 || row == h - 1) && (col == 0 || col == w - 1)
            return !isCorner
        }
    }

    private func meshLines(in size: CGSize) -> Path {
        var path = Path()
        let w = theme.mainGradient.meshAttributes.width
        let h = theme.mainGradient.meshAttributes.height

        for row in 0..<h {
            for col in 0..<w {
                let currentIndex = row * w + col

                let currentPt = theme.mainGradient.meshAttributes.points[currentIndex]
                let currentX = CGFloat(currentPt.x) * size.width
                let currentY = CGFloat(currentPt.y) * size.height

                if col < w - 1 {
                    let rightIndex = row * w + (col + 1)
                    let rightPt = theme.mainGradient.meshAttributes.points[rightIndex]
                    let rightX = CGFloat(rightPt.x) * size.width
                    let rightY = CGFloat(rightPt.y) * size.height

                    path.move(to: CGPoint(x: currentX, y: currentY))
                    path.addLine(to: CGPoint(x: rightX, y: rightY))
                }

                if row < h - 1 {
                    let bottomIndex = (row + 1) * w + col
                    let bottomPt = theme.mainGradient.meshAttributes.points[bottomIndex]
                    let bottomX = CGFloat(bottomPt.x) * size.width
                    let bottomY = CGFloat(bottomPt.y) * size.height

                    path.move(to: CGPoint(x: currentX, y: currentY))
                    path.addLine(to: CGPoint(x: bottomX, y: bottomY))
                }
            }
        }

        return path
    }

    private var selectedVertexColor: Color {
        guard theme.mainGradient.meshAttributes.colors.indices.contains(selectedVertexIndex) else {
            return Color.white
        }
        return theme.mainGradient.meshAttributes.colors[selectedVertexIndex].color
    }

    private func updateSelectedVertexColor(_ newColor: Color) {
        guard theme.mainGradient.meshAttributes.colors.indices.contains(selectedVertexIndex) else { return }

        if let components = newColor.toComponents() {
            theme.mainGradient.meshAttributes.colors[selectedVertexIndex] = RGBAColor(
                red: components.r,
                green: components.g,
                blue: components.b,
                alpha: components.a
            )
        }
    }

    private func updateMeshSize(newWidth: Int, newHeight: Int) {
        if newWidth == theme.mainGradient.meshAttributes.width, newHeight == theme.mainGradient.meshAttributes.height { return }

        let oldWidth = theme.mainGradient.meshAttributes.width
        let oldHeight = theme.mainGradient.meshAttributes.height

        let oldPoints = theme.mainGradient.meshAttributes.points
        let oldColors = theme.mainGradient.meshAttributes.colors

        theme.mainGradient.meshAttributes.width = newWidth
        theme.mainGradient.meshAttributes.height = newHeight

        var newPoints: [SIMD2<Float>] = Array(repeating: SIMD2<Float>(0, 0), count: newWidth * newHeight)
        var newColors: [RGBAColor] = Array(repeating: RGBAColor(.white), count: newWidth * newHeight)

        for row in 0..<newHeight {
            for col in 0..<newWidth {
                let newIndex = row * newWidth + col

                if row < oldHeight, col < oldWidth {
                    let oldIndex = row * oldWidth + col
                    newPoints[newIndex] = oldPoints[oldIndex]
                    newColors[newIndex] = oldColors[oldIndex]
                } else {
                    newPoints[newIndex] = SIMD2<Float>(Float(col) / Float(max(newWidth - 1, 1)),
                                                       Float(row) / Float(max(newHeight - 1, 1)))
                    newColors[newIndex] = RGBAColor.randomBright()
                }
            }
        }

        theme.mainGradient.meshAttributes.points = newPoints
        theme.mainGradient.meshAttributes.colors = newColors

        if !theme.mainGradient.meshAttributes.points.indices.contains(selectedVertexIndex) {
            selectedVertexIndex = theme.mainGradient.meshAttributes.points.count - 1
        }

        realignAllVertices()
    }

    private func realignAllVertices() {
        let w = theme.mainGradient.meshAttributes.width
        let h = theme.mainGradient.meshAttributes.height

        for row in 0..<h {
            for col in 0..<w {
                let index = row * w + col

                if w > 1 {
                    theme.mainGradient.meshAttributes.points[index].x = Float(col) / Float(w - 1)
                } else {
                    theme.mainGradient.meshAttributes.points[index].x = 0.5
                }

                if h > 1 {
                    theme.mainGradient.meshAttributes.points[index].y = Float(row) / Float(h - 1)
                } else {
                    theme.mainGradient.meshAttributes.points[index].y = 0.5
                }
            }
        }
    }
}

extension Color {
    func toComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        return (r, g, b, a)
    }
}
