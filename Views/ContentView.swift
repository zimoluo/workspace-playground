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
                    Text("My Notes")
                        .font(.largeTitle)
                        .fontWeight(.bold).themed(using: theme, in: colorScheme)
                    Spacer()
                    Button(action: addTheme) {
                        Image(systemName: "plus")
                            .font(.title2).foregroundStyle(themeColor(from: theme, for: "primary", in: colorScheme, level: 0))
                    }
                }
                .padding().background(themeColor(from: theme, for: "primary", in: colorScheme, level: 5))

                // Custom Scrollable Content
                ScrollView {
                    LazyVStack(spacing: 10) {
                        // Themes Section
                        let backgroundColor = themeColor(from: theme, for: "primary", in: colorScheme, level: 3)
                        let foregroundColor = themeColor(from: theme, for: "primary", in: colorScheme, level: 0)
                        SectionView(header: "Themes") {
                            ForEach(themes, id: \.id) { theme in
                                Text(theme.title)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        backgroundColor
                                    )
                                    .cornerRadius(8)
                                    .foregroundColor(
                                        foregroundColor
                                    )
                            }
                            .onDelete(perform: deleteThemes)
                        }
                        // Settings Section
                        NavigationLink(destination: SettingsView()) {
                            HStack {
                                Image(systemName: "gearshape")
                                Text("Settings")
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                themeColor(from: theme, for: "primary", in: colorScheme, level: 3)
                            )
                            .cornerRadius(8)
                            .foregroundColor(
                                themeColor(from: theme, for: "primary", in: colorScheme, level: 0)
                            )
                        }

                        NavigationLink(destination: ThemeMakerView()) {
                            HStack {
                                Image(systemName: "gearshape")
                                Text("Theme Maker")
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                themeColor(from: theme, for: "primary", in: colorScheme, level: 3)
                            )
                            .cornerRadius(8)
                            .foregroundColor(
                                themeColor(from: theme, for: "primary", in: colorScheme, level: 0)
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .background(LinearGradient(colors: [themeColor(from: theme, for: "primary", in: colorScheme, level: 4), themeColor(from: theme, for: "primary", in: colorScheme, level: 5)], startPoint: .bottom, endPoint: .top))
            }
        } detail: {
            // Main Content Area
            VStack {
                Text("Welcome to My Notes!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }.background(theme.mainGradient.toGradient())
        }.accentColor(themeColor(from: theme, for: "primary", in: colorScheme, level: 0))
    }

    private func addTheme() {
        let newTheme = Theme()
        modelContext.insert(newTheme)
    }

    private func deleteThemes(offsets: IndexSet) {
        for index in offsets {
            let theme = themes[index]
            modelContext.delete(theme)
        }
    }
}

struct SectionView<Content: View>: View {
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
            content
        }
        .padding(.vertical)
    }
}
