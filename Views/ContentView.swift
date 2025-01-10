import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query() var themes: [Theme]
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Themes")) {
                    ForEach(themes) { theme in
                        Text(theme.title)
                    }
                    .onDelete(perform: deleteThemes)
                }

                Section(header: Text("Settings")) {
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings").themed(using: theme, in: colorScheme)
                    }
                }
            }
            .navigationTitle("My Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addTheme) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
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
