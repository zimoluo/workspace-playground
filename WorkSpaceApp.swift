import SwiftData
import SwiftUI

@main
struct WorkSpaceApp: App {
    var body: some Scene {
        WindowGroup {
            SettingsProvider { theme in
                ContentView()
                    .environment(\.theme, theme)
            }.modelContainer(for: [Theme.self, Settings.self, Note.self])
        }
    }
}
