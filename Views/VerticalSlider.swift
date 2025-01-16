import SwiftUI

struct VerticalSlider: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var value: Int

    let range: ClosedRange<Int> = 2 ... 9

    private var totalSteps: Int {
        range.upperBound - range.lowerBound
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: geo.size.width / 2)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                themeColor(from: theme, for: .secondary, in: colorScheme, level: 1),
                                themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: geo.size.width)
                    .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 8, y: 6)

                ZStack {
                    Circle()
                        .fill(themeColor(from: theme, for: .secondary, in: .light, level: 5))
                        .frame(width: geo.size.width * 0.8, height: geo.size.width * 0.8)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 8, y: 6)
                    Text("\(value)")
                        .fontWeight(.bold)
                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: .light, level: 1))
                        .font(.title3)
                }
                .frame(width: geo.size.width, height: geo.size.width)
                .offset(y: thumbOffset(in: geo.size.height - geo.size.width))
                .gesture(
                    DragGesture()
                        .onChanged { drag in
                            let locationY = drag.location.y + geo.size.height - geo.size.width
                            let invertedY = geo.size.height - locationY
                            let stepHeight = (geo.size.height - geo.size.width / 2) / CGFloat(totalSteps)
                            let step = Int(round(invertedY / stepHeight))
                            let newValue = range.lowerBound + step
                            self.value = min(range.upperBound, max(range.lowerBound, newValue))
                        }
                )
            }
        }
        .frame(width: 40, height: 212)
    }

    private func thumbOffset(in totalHeight: CGFloat) -> CGFloat {
        let stepHeight = totalHeight / CGFloat(totalSteps)
        let stepsAboveBottom = value - range.lowerBound
        let offset = CGFloat(stepsAboveBottom) * stepHeight
        return -offset
    }
}
