import SwiftUI

@main
struct WorkSpaceApp: App {
    @StateObject var settings = Settings(theme: Theme())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.theme, settings.theme) // Inject theme into the environment
                .environmentObject(settings) // Provide settings as an environment object
                .environment(\.globalTextColor, ColorUtils.colorFromRGB(settings.theme.primary))
                .accentColor(ColorUtils.colorFromRGB(settings.theme.accentColor)) // Use theme's accentColor
                .onAppear {
                    NavigationAppearanceUtils.applyNavigationBarTheme(theme: settings.theme)
                }
                .onChange(of: settings.theme.accentColor) {
                    // No need to reapply `.accentColor` here; it's dynamically updated.
                }
        }
    }
}
