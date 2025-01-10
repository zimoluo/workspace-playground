import SwiftData
import SwiftUI

@main
struct WorkSpaceApp: App {
    @Query private var settings: [Settings]
    @Environment(\.modelContext) private var modelContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Theme.self, Settings.self])
                .environment(\.theme, effectiveSettings().theme)
        }
    }

    private func effectiveSettings() -> Settings {
        if let currentSettings = settings.first {
            return currentSettings
        } else {
            let defaultSettings = Settings() // Create the default settings
            modelContext.insert(defaultSettings) // Save it to the database
            return defaultSettings
        }
    }
}
