import SwiftUI

struct ClockWidget: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @State private var currentTime = Date()
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

                        HandView(length: geometry.size.width * 0.25, width: 6, rotation: hourRotation(), color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 1), shadowColor: theme.secondary.toShadow())

                        HandView(length: geometry.size.width * 0.35, width: 3.6, rotation: minuteRotation(), color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 1), shadowColor: theme.secondary.toShadow())

                        HandView(length: geometry.size.width * 0.4, width: 1.6, rotation: secondRotation(), color: themeColor(from: theme, for: .secondary, in: colorScheme, level: 2), shadowColor: theme.secondary.toShadow())

                        Circle() // Center Circle
                            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                            .frame(width: 12, height: 12)
                    }
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)

                    Spacer()
                }
            }
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentTime = Date()
                }
            }
        }
    }

    private func hourRotation() -> Angle {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime) % 12
        let minute = calendar.component(.minute, from: currentTime)
        return .degrees(Double(hour) * 30 + Double(minute) / 2)
    }

    private func minuteRotation() -> Angle {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: currentTime)
        let second = calendar.component(.second, from: currentTime)
        return .degrees(Double(minute) * 6 + Double(second) / 10)
    }

    private func secondRotation() -> Angle {
        let calendar = Calendar.current
        let second = calendar.component(.second, from: currentTime)
        return .degrees(Double(second) * 6)
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
