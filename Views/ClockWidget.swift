import SwiftUI

struct ClockWidget: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @State private var currentTime = Date()
    @State private var previousSecondAngle: Double = 0
    @State private var previousMinuteAngle: Double = 0
    @State private var previousHourAngle: Double = 0

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear.ignoresSafeArea()

                VStack {
                    Spacer()

                    ZStack {
                        ForEach(0 ..< 12) { tick in
                            Rectangle()
                                .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1).opacity(0.8))
                                .frame(width: 2.6, height: geometry.size.width * 0.075)
                                .offset(y: -geometry.size.width * 0.4)
                                .rotationEffect(.degrees(Double(tick) * 30))
                        }

                        HandView(
                            length: geometry.size.width * 0.25,
                            width: 6,
                            rotation: hourRotation(),
                            color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 1),
                            shadowColor: theme.secondary.toShadow()
                        )

                        HandView(
                            length: geometry.size.width * 0.35,
                            width: 3.6,
                            rotation: minuteRotation(),
                            color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 1),
                            shadowColor: theme.secondary.toShadow()
                        )

                        HandView(
                            length: geometry.size.width * 0.4,
                            width: 1.6,
                            rotation: secondRotation(),
                            color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 2),
                            shadowColor: theme.secondary.toShadow()
                        )

                        Circle()
                            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                            .frame(width: 12, height: 12)
                    }
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)

                    Spacer()
                }
            }
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    updateAngles()
                    currentTime = Date()
                }
            }
        }
    }

    private func updateAngles() {
        previousSecondAngle = calculateContinuousAngle(from: previousSecondAngle, to: calculateSecondAngle())
        previousMinuteAngle = calculateContinuousAngle(from: previousMinuteAngle, to: calculateMinuteAngle())
        previousHourAngle = calculateContinuousAngle(from: previousHourAngle, to: calculateHourAngle())
    }

    private func calculateContinuousAngle(from previous: Double, to current: Double) -> Double {
        if current < previous && (previous - current) > 180 {
            return current + 360 // Smooth forward transition
        } else if current > previous && (current - previous) > 180 {
            return current - 360 // Smooth backward transition
        }
        return current
    }

    private func hourRotation() -> Angle {
        return .degrees(previousHourAngle)
    }

    private func minuteRotation() -> Angle {
        return .degrees(previousMinuteAngle)
    }

    private func secondRotation() -> Angle {
        return .degrees(previousSecondAngle)
    }

    private func calculateHourAngle() -> Double {
        let calendar = Calendar.current
        let hour = Double(calendar.component(.hour, from: currentTime) % 12)
        let minute = Double(calendar.component(.minute, from: currentTime))
        return (hour + minute / 60.0) * 30
    }

    private func calculateMinuteAngle() -> Double {
        let calendar = Calendar.current
        let minute = Double(calendar.component(.minute, from: currentTime))
        let second = Double(calendar.component(.second, from: currentTime))
        return (minute + second / 60.0) * 6
    }

    private func calculateSecondAngle() -> Double {
        let calendar = Calendar.current
        let second = Double(calendar.component(.second, from: currentTime))
        let nanosecond = Double(calendar.component(.nanosecond, from: currentTime))
        return (second + nanosecond / 1_000_000_000.0) * 6
    }
}

struct HandView: View {
    var length: CGFloat
    var width: CGFloat
    var rotation: Angle
    var color: Color = .white
    var shadowColor: Color = .black.opacity(0.2)

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: length)
            .cornerRadius(width / 2)
            .offset(y: -length / 2)
            .rotationEffect(rotation)
            .shadow(color: shadowColor, radius: 0.6)
    }
}

struct ClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClockWidget()
    }
}
