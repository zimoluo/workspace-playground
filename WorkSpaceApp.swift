import SwiftData
import SwiftUI

@main
struct WorkSpaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Note.self, Settings.self])
        }
    }
}
