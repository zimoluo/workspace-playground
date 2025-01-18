import SwiftData
import SwiftUI

@main
struct WorkSpaceApp: App {
    var body: some Scene {
        WindowGroup {
            SettingsProvider { theme, settings in
                ContentView()
                    .environment(\.theme, theme)
                    .environment(\.settings, settings)
                    .environment(\.popUp, .empty)
            }.modelContainer(for: [Theme.self, Settings.self, Note.self])
        }
    }
}
