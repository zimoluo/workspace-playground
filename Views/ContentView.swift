import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query() var themes: [Theme]
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                HStack {
                    Text("WorkSpace")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .themedForeground(using: theme, in: colorScheme)
                    Spacer()
                }
                .padding(16)
                .background(themeColor(from: theme, for: .primary, in: colorScheme, level: 5))

                VStack(spacing: 10) {
                    let backgroundColor = themeColor(from: theme, for: .primary, in: colorScheme, level: 3)
                    let foregroundColor = themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                    SectionView(header: "Spaces") {
                        Text("Until we meet again")
                            .fontWeight(.semibold)
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                backgroundColor
                            )
                            .cornerRadius(16)
                            .foregroundColor(
                                foregroundColor
                            )
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    }

                    // not really a spacer down below. the "spaces" section will be having a vertical stack that takes as much space possible until it clashes with the thing below in which case it scrolls.
                    Spacer()

                    // make this a "Theme" section.
                    // make a grid or a grid-like thing here with similar styling to hstack. and then place every member of themes, except the one whose id equal to theme.id, a circle for each, filled in eachTheme.thumbnail (it's a gradient). the grid will have a similar styling (bg, fg, padding, corner, shadow) to the hstack below. its max height does not exceed 240, so you need to scroll if necessary. the spacing between each grid item is 16, and each circle should have diameter 32. there will be a clicking action on the circle/button. i'll implement that part.

                    NavigationLink(destination: ThemeMakerView()) {
                        HStack(spacing: 12) {
                            Image(systemName: "paintpalette").font(.title2)
                                .frame(width: 24, height: 24)
                            Text("Theme Maker")
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 3)
                        )
                        .cornerRadius(16)
                        .foregroundColor(
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                        )
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    }
                }
                .padding(.horizontal, 16)
                .background(LinearGradient(colors: [themeColor(from: theme, for: .primary, in: colorScheme, level: 4), themeColor(from: theme, for: .primary, in: colorScheme, level: 5)], startPoint: .bottom, endPoint: .top))
            }
        } detail: {
            theme.mainGradient.toGradient(in: colorScheme).ignoresSafeArea()
        }.accentColor(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
    }
}

struct SectionView<Content: View>: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    let header: String
    let content: Content

    init(header: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(header)
                .font(.headline)
                .padding(.bottom, 5)
                .themedForeground(using: theme, in: colorScheme)
            content
        }
        .padding(.vertical, 16)
    }
}
