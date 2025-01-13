import SwiftUI

struct VerticalSnapSelector: View {
    @State private var selectedIndex: Int = 0
    let items: [String] = ["sun.max", "moon", "cloud", "wind", "snowflake"]
    let maxDistance: CGFloat = 360

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(items.indices, id: \.self) { index in
                        Image(systemName: items[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 85, height: 85)
                            .foregroundStyle(selectedIndex == index ? Color.red : Color.black)
                            .scrollTransition { phase in
                                let progress = phase.relativePosition
                                let scale = calculateScale(relativePosition: progress)
                                let opacity = calculateOpacity(relativePosition: progress)
                                let translation = calculateTranslation(relativePosition: progress)

                                return AnyTransition
                                    .identity
                                    .combined(with: .scale(scale))
                                    .combined(with: .opacity(opacity))
                                    .combined(with: .offset(y: translation * maxDistance))
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedIndex = index
                                    scrollViewProxy.scrollTo(index, anchor: .center)
                                }
                            }
                            .id(index)
                    }
                }
                .padding(.vertical, UIScreen.main.bounds.height / 2 - 50)
            }
            .onChange(of: selectedIndex) { _ in
                // Optional: Handle selection change if needed
            }
        }
    }

    private func calculateScale(relativePosition: CGFloat) -> CGFloat {
        // Bezier curve for smooth scaling
        let bezierCurve: (CGFloat) -> CGFloat = { x in
            1 - 3 * pow(x, 2) + 2 * pow(x, 3)
        }
        let clamped = min(max(0, relativePosition), 1)
        return bezierCurve(clamped)
    }

    private func calculateOpacity(relativePosition: CGFloat) -> CGFloat {
        let scale = calculateScale(relativePosition: relativePosition)
        return pow(scale, 1.7)
    }

    private func calculateTranslation(relativePosition: CGFloat) -> CGFloat {
        if relativePosition > 1 {
            return 0
        }
        return pow(relativePosition, 3) * (relativePosition > 0 ? -1 : 1)
    }
}

struct VerticalSnapSelector_Previews: PreviewProvider {
    static var previews: some View {
        VerticalSnapSelector()
    }
}
