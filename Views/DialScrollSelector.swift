import SwiftUI

struct VerticalSnapSelector: View {
    @State private var selectedIndex: Int = 0
    let items: [String] = ["sun.max", "moon", "cloud", "wind", "snowflake"]
    let maxDistance: CGFloat = 360

    var body: some View {
        GeometryReader { outerGeometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(items.indices, id: \.self) { index in
                        GeometryReader { innerGeometry in
                            let centerY = outerGeometry.size.height / 2
                            let itemY = innerGeometry.frame(in: .global).midY
                            let distance = abs(itemY - centerY)
                            let transform = calculateTransform(distance: distance, maxDistance: maxDistance, translationMultiplier: itemY > centerY ? -1 : 1)

                            Image(systemName: items[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 85, height: 85)
                                .scaleEffect(transform.scale)
                                .opacity(transform.opacity)
                                .offset(y: transform.translation * maxDistance)
                                .onAppear {
                                    if distance < 1 {
                                        withAnimation {
                                            selectedIndex = index
                                        }
                                    }
                                }
                        }
                        .frame(height: 100)
                    }
                }
                .padding(.vertical, outerGeometry.size.height / 2 - 50)
            }
            .gesture(
                DragGesture()
                    .onEnded { _ in
                        let snapIndex = round(Double(selectedIndex))
                        withAnimation {
                            selectedIndex = Int(snapIndex)
                        }
                    }
            )
        }
    }

    private func calculateTransform(distance: CGFloat, maxDistance: CGFloat, translationMultiplier: CGFloat = 1) -> (scale: CGFloat, opacity: CGFloat, translation: CGFloat) {
        let normalizedDistance = distance / maxDistance
        let clampedDistance = min(max(0, normalizedDistance), 1)
        let bezierCurve: (CGFloat) -> CGFloat = { x in 1 - 3 * pow(x, 2) + 2 * pow(x, 3) }
        let scale = bezierCurve(clampedDistance)
        let opacity = pow(bezierCurve(clampedDistance), 1.7)
        let translation = normalizedDistance > 1 ? 0 : (pow(normalizedDistance, 3) * translationMultiplier)
        return (scale, opacity, translation)
    }
}

struct VerticalSnapSelector_Previews: PreviewProvider {
    static var previews: some View {
        VerticalSnapSelector()
    }
}
