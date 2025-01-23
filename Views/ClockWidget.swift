import SwiftUI

struct ClockWidget: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @State private var currentTime = Date()
    private let timer = Timer.publish(every: 1 / 60, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear.ignoresSafeArea()

                VStack {
                    Spacer()

                    ZStack {
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let shorterSide = min(width, height)
                        let longerSide = max(width, height)

                        ForEach(0 ..< 12) { tick in
                            RoundedRectangle(cornerRadius: 9999)
                                .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1).opacity(0.8))
                                .frame(width: sqrt(longerSide / shorterSide) * 2.6, height: longerSide * 0.075)
                                .offset(y: -longerSide * 0.4)
                                .rotationEffect(.degrees(ellipseAngle(originalAngle: Double(tick) * 30, aspect: width / height)))
                                .scaleEffect(x: width / longerSide, y: height / longerSide)
                        }

                        HandView(
                            length: shorterSide * 0.25,
                            width: 6,
                            rotation: hourRotation(),
                            color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 1),
                            shadowColor: theme.secondary.toShadow()
                        )

                        HandView(
                            length: shorterSide * 0.35,
                            width: 3.6,
                            rotation: minuteRotation(),
                            color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 1),
                            shadowColor: theme.secondary.toShadow()
                        )

                        HandView(
                            length: shorterSide * 0.4,
                            width: 1.6,
                            rotation: secondRotation(),
                            color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 2),
                            shadowColor: theme.secondary.toShadow()
                        )

                        Circle()
                            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                            .frame(width: 12, height: 12)
                    }
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)

                    Spacer()
                }
            }
            .onReceive(timer) { _ in
                currentTime = Date()
            }
        }
    }

    private func hourRotation() -> Angle {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime) % 12
        let minute = calendar.component(.minute, from: currentTime)
        let second = calendar.component(.second, from: currentTime)
        let fractionalHour = Double(hour) + Double(minute) / 60 + Double(second) / 3600
        return .degrees(fractionalHour * 30)
    }

    private func minuteRotation() -> Angle {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: currentTime)
        let second = calendar.component(.second, from: currentTime)
        let fractionalMinute = Double(minute) + Double(second) / 60
        return .degrees(fractionalMinute * 6)
    }

    private func secondRotation() -> Angle {
        let calendar = Calendar.current
        let second = calendar.component(.second, from: currentTime)
        let nanosecond = calendar.component(.nanosecond, from: currentTime)
        let fractionalSecond = Double(second) + Double(nanosecond) / 1000000000
        return .degrees(fractionalSecond * 6)
    }

    private func ellipseAngle(originalAngle: CGFloat, aspect: CGFloat) -> CGFloat {
        let theta = originalAngle * .pi / 180.0

        let tanPhi = tan(theta) / aspect
        let phi = atan(tanPhi)

        if originalAngle > 90 && originalAngle <= 270 {
            return (phi + .pi) * 180.0 / .pi
        } else if originalAngle > 270 {
            return (phi + 2 * .pi) * 180.0 / .pi
        }

        return phi * 180.0 / .pi
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
