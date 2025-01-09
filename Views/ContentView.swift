import SwiftUI

struct ContentView: View {
    @Environment(\.theme) var theme // Access the theme from the environment
    @EnvironmentObject var settings: Settings

    var body: some View {
        SettingsListView(settings: settings)
    }
}
