import SwiftUI

struct TipsView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var popUp: PopUp

    var body: some View {
        GeometryReader { geometry in
            let shorterSide = min(geometry.size.width, geometry.size.height)
            ZStack {
                Color.clear.ignoresSafeArea()

                Button(action: {
                    popUp.type = .tips_menu
                }) {
                    Image(systemName: "lightbulb.max")
                        .font(.system(size: shorterSide * 0.4))
                        .frame(width: shorterSide * 0.55, height: shorterSide * 0.55)
                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                }
                .frame(width: shorterSide * 0.55, height: shorterSide * 0.55)
                .gesture(DragGesture().onChanged { _ in })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    TipsView()
}
