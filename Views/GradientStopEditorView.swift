import SwiftUI

struct GradientStopEditorView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme
    @State private var selectedStop: Int? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ColorPicker("", selection: Binding(
                    get: {
                        guard let selectedStop else { return .clear }
                        let stopColor = theme.mainGradient.stops[selectedStop].color
                        return stopColor.color
                    },
                    set: { newColor in
                        guard let selectedStop else { return }
                        if let components = newColor.cgColor?.components, components.count >= 3 {
                            theme.mainGradient.stops[selectedStop].color = RGBAColor(
                                red: components[0],
                                green: components[1],
                                blue: components[2]
                            )
                        }
                    }
                ))
                .frame(width: 24, height: 24)
                .transition(.scale.combined(with: .opacity))
                .opacity((selectedStop != nil) ? 1 : 0)
                .scaleEffect((selectedStop != nil) ? 0.8 : 0.7)
                .blur(radius: (selectedStop != nil) ? 0 : 5)
                .animation(.easeInOut(duration: 0.3), value: selectedStop)

                Spacer()

                Button(action: {
                    if let selectedIndex = selectedStop {
                        removeStop(at: selectedIndex)
                    }
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title2)
                        .themedForeground(using: theme, in: colorScheme, category: .secondary)
                        .opacity((selectedStop != nil && theme.mainGradient.stops.count > 2) ? 1 : 0)
                        .scaleEffect((selectedStop != nil && theme.mainGradient.stops.count > 2) ? 1 : 0.8)
                        .blur(radius: (selectedStop != nil && theme.mainGradient.stops.count > 2) ? 0 : 5)
                }
                .disabled(!(selectedStop != nil && theme.mainGradient.stops.count > 2))
                .animation(.easeInOut(duration: 0.3), value: selectedStop)

                Button(action: {
                    selectedStop = nil
                }) {
                    Image(systemName: "circle.dashed")
                        .font(.title2)
                        .themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)
                        .opacity(selectedStop != nil ? 1 : 0)
                        .scaleEffect(selectedStop != nil ? 1 : 0.8)
                        .blur(radius: selectedStop != nil ? 0 : 5)
                }
                .disabled(!(selectedStop != nil))
                .animation(.easeInOut(duration: 0.3), value: selectedStop)

                Button(action: {
                    if let selectedIndex = selectedStop {
                        let newPosition = theme.mainGradient.stops[selectedIndex].position + 0.05
                        addStop(at: newPosition > 1 ? theme.mainGradient.stops[selectedIndex].position - 0.05 : newPosition)
                    } else {
                        addStop(at: 0.5)
                    }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)
                }

                Button(action: {
                    reverseStops()
                }) {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.title2)
                        .themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)
                }

                Button(action: {
                    evenOutStops()
                }) {
                    Image(systemName: "grid.circle")
                        .font(.title2)
                        .themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)
                }
            }

            ZStack {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let gradient = LinearGradient(
                        gradient: Gradient(stops: theme.mainGradient.stops
                            .sorted { $0.position < $1.position }
                            .map { $0.toSwiftUIStop(in: colorScheme) }),
                        startPoint: .leading,
                        endPoint: .trailing
                    )

                    Rectangle()
                        .fill(gradient)
                        .frame(height: 32)
                        .cornerRadius(12)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let tapLocation = value.location.x
                                    let position = Double(tapLocation / width)
                                    addStop(at: position.clamped(to: 0.0...1.0))
                                }
                        )

                    ForEach(theme.mainGradient.stops.indices, id: \.self) { index in
                        let stop = theme.mainGradient.stops[index]

                        let circleShadeMap = stop.color.shadeMap(numShades: 16, saturationMultiplier: 0.6)

                        let circleColor = circleShadeMap.index > 5 ? circleShadeMap.shadeMap[0] : circleShadeMap.shadeMap[10]

                        ZStack {
                            // Pin shape
                            Path { path in
                                path.move(to: CGPoint(x: 10, y: 0))
                                path.addLine(to: CGPoint(x: 20, y: 10))
                                path.addLine(to: CGPoint(x: 20, y: 30))
                                path.addLine(to: CGPoint(x: 0, y: 30))
                                path.addLine(to: CGPoint(x: 0, y: 10))
                                path.closeSubpath()
                            }
                            .fill(stop.color.color)
                            .frame(width: 20, height: 30)
                            .cornerRadius(5)

                            // Selection indicator
                            if selectedStop == index {
                                Circle()
                                    .fill(circleColor.color)
                                    .frame(width: 9, height: 9)
                                    .offset(y: 3)
                            }
                        }
                        .frame(width: 20, height: 20)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                        .position(x: CGFloat(stop.position) * width, y: 50)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    updateStopPosition(index: index, newPosition: Double(value.location.x / width))
                                    if selectedStop != index {
                                        selectedStop = index
                                    }
                                }
                        )
                        .onTapGesture {
                            selectedStop = index
                        }
                    }
                }
            }
            .frame(height: 60)
        }
        .padding(8)
    }

    private func addStop(at position: Double) {
        let clampedPosition = position.clamped(to: 0.0...1.0)

        // Find the stops on the left and right
        let sortedStops = theme.mainGradient.stops.sorted { $0.position < $1.position }
        let leftStop = sortedStops.last { $0.position <= clampedPosition }
        let rightStop = sortedStops.first { $0.position >= clampedPosition }

        // Determine the new color
        let newColor: RGBAColor
        if let left = leftStop, let right = rightStop {
            if left.position == right.position {
                // If both stops have the same position, use that color
                newColor = left.color
            } else {
                // Blend the colors based on the relative position
                let relativePosition = (clampedPosition - left.position) / (right.position - left.position)
                newColor = blendColors(color1: left.color, color2: right.color, ratio: relativePosition)
            }
        } else if let left = leftStop {
            // No stop on the right, use the left stop's color
            newColor = left.color
        } else if let right = rightStop {
            // No stop on the left, use the right stop's color
            newColor = right.color
        } else {
            // Default color if no stops exist (shouldn't happen in this case)
            newColor = RGBAColor(red: 0.5, green: 0.5, blue: 0.5)
        }

        // Add the new stop
        let newStop = GradientStop(color: newColor, position: clampedPosition)
        theme.mainGradient.stops.append(newStop)
        selectedStop = theme.mainGradient.stops.count - 1
    }

    private func blendColors(color1: RGBAColor, color2: RGBAColor, ratio: Double) -> RGBAColor {
        let inverseRatio = 1.0 - ratio
        return RGBAColor(
            red: color1.red * inverseRatio + color2.red * ratio,
            green: color1.green * inverseRatio + color2.green * ratio,
            blue: color1.blue * inverseRatio + color2.blue * ratio
        )
    }

    private func removeStop(at index: Int) {
        guard theme.mainGradient.stops.count > 2 else { return }
        theme.mainGradient.stops.remove(at: index)
        selectedStop = nil
    }

    private func reverseStops() {
        theme.mainGradient.stops = theme.mainGradient.stops.map { stop in
            var reversedStop = stop
            reversedStop.position = 1.0 - stop.position
            return reversedStop
        }
    }

    private func evenOutStops() {
        guard theme.mainGradient.stops.count > 1 else { return }

        let sortedStops = theme.mainGradient.stops.enumerated()
            .sorted(by: { $0.element.position < $1.element.position })

        let totalStops = sortedStops.count
        let evenlyDistributedPositions = stride(from: 0.0, through: 1.0, by: 1.0 / Double(totalStops - 1))

        for (newIndex, (originalIndex, _)) in zip(evenlyDistributedPositions, sortedStops) {
            theme.mainGradient.stops[originalIndex].position = newIndex
        }
    }

    private func updateStopPosition(index: Int, newPosition: Double) {
        theme.mainGradient.stops[index].position = newPosition.clamped(to: 0.0...1.0)
    }
}

extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

struct GradientStopEditorView_Previews: PreviewProvider {
    static var previews: some View {
        GradientStopEditorView()
            .environment(\.theme, Theme())
    }
}
