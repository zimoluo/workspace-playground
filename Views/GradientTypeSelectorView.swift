import SwiftUI

struct GradientTypeSelectorView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var gradientTypes: [GradientType] = GradientType.allCases
    
    var body: some View {
        GeometryReader { geometry in
            let totalItems = gradientTypes.count
            let selectedCount = 3
            let unselectedCount = 2 * (totalItems - 1)
            let totalFractions = selectedCount + unselectedCount
            let spacing: CGFloat = 12
            let fractionHeight = (geometry.size.height - spacing * CGFloat(totalItems - 1)) / CGFloat(totalFractions)
            let itemWidth = 2 * fractionHeight
 
            VStack(spacing: spacing) {
                ForEach(gradientTypes, id: \.self) { gradientType in
                    let isSelected = theme.mainGradient.type == gradientType
                    let itemHeight = isSelected ? 3 * fractionHeight : 2 * fractionHeight
                        
                    VStack(spacing: 12) {
                        Image(gradientType.symbol)
                            .resizable()
                            .scaledToFit()
                            .frame(width: itemWidth * 0.7, height: itemWidth * 0.7)
                            .clipShape(Circle())
                            
                        if isSelected {
                            Text(gradientType.title)
                                .font(.headline)
                                .transition(.opacity)
                                .fontWeight(.bold)
                        }
                    }
                    .frame(height: itemHeight)
                    .frame(maxWidth: .infinity)
                    .background(
                        themeColor(from: theme, for: .secondary, in: colorScheme, level: isSelected ? 1 : 5)
                    )
                    .cornerRadius(16)
                    .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    .onTapGesture {
                        withAnimation(.spring()) { // Smooth animation
                            theme.mainGradient.type = gradientType
                        }
                    }
                    .foregroundColor(
                        themeColor(from: theme, for: .secondary, in: colorScheme, level: isSelected ? 5 : 1)
                    )
                }
            }
            .frame(width: itemWidth, height: geometry.size.height)
        }
    }
}

#Preview {
    GradientTypeSelectorView()
}
