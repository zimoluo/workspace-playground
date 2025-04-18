import SwiftData
import SwiftUI

@main
struct WorkSpaceApp: App {
    @StateObject private var popUp = PopUp()

    var body: some Scene {
        WindowGroup {
            SettingsProvider { theme, settings in
                ContentView()
                    .environment(\.theme, theme)
                    .environment(\.settings, settings)
                    .environmentObject(popUp)
            }.modelContainer(for: [Theme.self, Settings.self, Space.self, StoredImage.self])
        }
    }
}
