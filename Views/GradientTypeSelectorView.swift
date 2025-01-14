import SwiftUI

struct GradientTypeSelectorView: View {
    @State private var selectedIndex: Int = 0

    let items: [String] = ["sun.max", "moon", "cloud", "wind", "snowflake"]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(items.indices, id: \.self) { index in
                    Image(systemName: items[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .scaleEffect(phase.isIdentity ? 1 : 0.2)
                                .blur(radius: phase.isIdentity ? 0 : 8)
                                .offset(y: phase.value * -30)
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedIndex = index
                            }
                        }
                        .foregroundStyle(selectedIndex == index ? Color.red : Color.primary)
                }
            }.padding(.vertical, 128)
        }
    }
}

struct GradientTypeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GradientTypeSelectorView()
    }
}
