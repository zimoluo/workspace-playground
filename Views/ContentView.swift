import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query() var themes: [Theme]
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            HStack {
                Text("My Notes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: addTheme) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
            }
            .padding()
            .background(Color.red)

            // Custom Scrollable Content
            ScrollView {
                LazyVStack(spacing: 10) {
                    // Themes Section
                    SectionView(header: "Themes") {
                        ForEach(themes, id: \.id) { theme in
                            Text(theme.title)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    getThemeColor(from: theme, for: "primary", in: colorScheme, level: 3)
                                )
                                .cornerRadius(8)
                                .foregroundColor(
                                    getThemeColor(from: theme, for: "primary", in: colorScheme, level: 0)
                                )
                        }
                        .onDelete(perform: deleteThemes)
                    }

                    // Settings Section
                    SectionView(header: "Settings") {
                        NavigationLink(destination: SettingsView()) {
                            Text("Settings")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.secondary.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.red) // Custom Background for ScrollView
        }
        .ignoresSafeArea(edges: .top) // Extend background to the top
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
