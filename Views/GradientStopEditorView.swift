import SwiftUI

struct GradientStopEditorView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var stops: [GradientStop] = [
        GradientStop(color: RGBAColor(red: 0.0, green: 0.0, blue: 1.0), position: 0.0),
        GradientStop(color: RGBAColor(red: 1.0, green: 0.0, blue: 1.0), position: 1.0)
    ]
    @State private var selectedStop: Int? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ColorPicker("", selection: Binding(
                    get: {
                        guard let selectedStop else { return .clear }
                        let stopColor = stops[selectedStop].color
                        return stopColor.color
                    },
                    set: { newColor in
                        guard let selectedStop else { return }
                        if let components = newColor.cgColor?.components {
                            stops[selectedStop].color = RGBAColor(
                                red: components[0],
                                green: components[1],
                                blue: components[2]
                            )
                        }
                    }
                ))
                .frame(width: 24, height: 24)
                .transition(.scale.combined(with: .opacity)) // Scale and fade-in effect
                .opacity((selectedStop != nil) ? 1 : 0) // Adjust opacity
                .scaleEffect((selectedStop != nil) ? 0.8 : 0.7) // Scale effect
                .blur(radius: (selectedStop != nil) ? 0 : 5) // Blur effect
                .animation(.easeInOut(duration: 0.3), value: selectedStop)

                Spacer()

                Button(action: {
                    if let selectedIndex = selectedStop {
                        removeStop(at: selectedIndex)
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title2)
                        .opacity((selectedStop != nil && stops.count > 2) ? 1 : 0) // Adjust opacity
                        .scaleEffect((selectedStop != nil && stops.count > 2) ? 1 : 0.8) // Scale effect
                        .blur(radius: (selectedStop != nil && stops.count > 2) ? 0 : 5) // Blur effect
                }
                .disabled(!(selectedStop != nil && stops.count > 2)) // Disable the button when conditions are not met
                .animation(.easeInOut(duration: 0.3), value: selectedStop)

                Button(action: {
                    if let selectedIndex = selectedStop {
                        let newPosition = stops[selectedIndex].position + 0.05
                        addStop(at: newPosition > 1 ? stops[selectedIndex].position - 0.05 : newPosition)
                    } else {
                        addStop(at: 0.5)
                    }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                }

                Button(action: {
                    reverseStops()
                }) {
                    Image(systemName: "arrow.uturn.left.circle")
                        .font(.title2)
                }
            }

            ZStack {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let gradient = LinearGradient(
                        gradient: Gradient(stops: stops
                            .sorted { $0.position < $1.position }
                            .map { $0.toSwiftUIStop(in: colorScheme) }),
                        startPoint: .leading,
                        endPoint: .trailing
                    )

                    Rectangle()
                        .fill(gradient)
                        .frame(height: 32)
                        .cornerRadius(12)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let tapLocation = value.location.x
                                    let position = Double(tapLocation / width)
                                    addStop(at: position.clamped(to: 0.0...1.0))
                                }
                        )

                    ForEach(0 ..< stops.count, id: \..self) { index in
                        let stop = stops[index]

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
                                    .fill(Color.white)
                                    .frame(width: 9, height: 9)
                                    .offset(y: 3)
                            }
                        }
                        .frame(width: 20, height: 20)
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
        let sortedStops = stops.sorted { $0.position < $1.position }
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
        stops.append(newStop)
        selectedStop = stops.count - 1
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
        guard stops.count > 2 else { return }
        stops.remove(at: index)
        selectedStop = nil
    }

    private func reverseStops() {
        stops = stops.map { stop in
            var reversedStop = stop
            reversedStop.position = 1.0 - stop.position
            return reversedStop
        }
    }

    private func updateStopPosition(index: Int, newPosition: Double) {
        stops[index].position = newPosition.clamped(to: 0.0...1.0)
    }
}

extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

#Preview {
    GradientStopEditorView()
}
