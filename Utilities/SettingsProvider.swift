import SwiftData
import SwiftUI

struct SettingsProvider<Content: View>: View {
    @Environment(\.modelContext) private var modelContext
    @Query var settings: [Settings]

    let content: (Theme, Settings) -> Content

    var body: some View {
        Group {
            if let currentSettings = settings.first {
                content(currentSettings.theme, currentSettings)
                    .task {
                        await initializeDefaultsIfNeeded(currentSettings)
                    }
            } else {
                ProgressView("Loading settings...")
                    .onAppear(perform: ensureSettingsExist)
            }
        }
    }

    private func ensureSettingsExist() {
        if settings.isEmpty {
            let defaultSettings = Settings()
            modelContext.insert(defaultSettings)
            try? modelContext.save()
        }
    }

    private func initializeDefaultsIfNeeded(_ currentSettings: Settings) async {
        let hasInitializedDefaults = UserDefaults.standard.bool(forKey: "HasInitializedDefaults")

        guard !hasInitializedDefaults else {
            return
        }

        let defaultThemes: [Theme] = [
            BuiltinThemes.cold,
            BuiltinThemes.cherry,
            BuiltinThemes.warm,
            BuiltinThemes.whim,
        ]

        for theme in defaultThemes {
            modelContext.insert(theme)
        }

        let doodleSpace = BuiltinSpaces.doodle

        let defaultSpaces: [Space] = [
            doodleSpace,
        ]

        for space in defaultSpaces {
            modelContext.insert(space)
        }

        do {
            try modelContext.save()
            UserDefaults.standard.set(true, forKey: "HasInitializedDefaults")
            currentSettings.selectedSpaceId = doodleSpace.id
        } catch {
            print("Error initializing default data: \(error)")
        }
    }
}
