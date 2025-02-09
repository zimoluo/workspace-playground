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

        let firstSpace = BuiltinSpaces.productivity
        let personalSpace = BuiltinSpaces.personal
        let writingSpace = BuiltinSpaces.writing
        let doodleSpace = BuiltinSpaces.doodle

        firstSpace.dateCreated = Calendar.current.date(byAdding: .minute, value: -90, to: Date()) ?? Date()
        writingSpace.dateCreated = Calendar.current.date(byAdding: .minute, value: -120, to: Date()) ?? Date()
        personalSpace.dateCreated = Calendar.current.date(byAdding: .minute, value: -150, to: Date()) ?? Date()
        doodleSpace.dateCreated = Calendar.current.date(byAdding: .minute, value: -180, to: Date()) ?? Date()

        firstSpace.dateModified = Calendar.current.date(byAdding: .minute, value: -90, to: Date()) ?? Date()
        writingSpace.dateModified = Calendar.current.date(byAdding: .minute, value: -120, to: Date()) ?? Date()
        personalSpace.dateModified = Calendar.current.date(byAdding: .minute, value: -150, to: Date()) ?? Date()
        doodleSpace.dateModified = Calendar.current.date(byAdding: .minute, value: -180, to: Date()) ?? Date()

        let defaultSpaces: [Space] = [
            doodleSpace,
            personalSpace,
            writingSpace,
            firstSpace,
        ]

        for space in defaultSpaces {
            modelContext.insert(space)
        }

        do {
            try modelContext.save()
            UserDefaults.standard.set(true, forKey: "HasInitializedDefaults")
            currentSettings.selectedSpaceId = firstSpace.id
            currentSettings.habits = [
                Habit(id: UUID(), name: "Writing ✏️", dateCreated: Calendar.current.date(byAdding: .day, value: -60, to: Date()) ?? Date(), dateModified: Calendar.current.date(byAdding: .day, value: -60, to: Date()) ?? Date(), timesKept: [Date(), Date(), Date(), Date()], timesDisliked: []),
                Habit(id: UUID(), name: "Coding 🧑‍💻", dateCreated: Calendar.current.date(byAdding: .day, value: -75, to: Date()) ?? Date(), dateModified: Calendar.current.date(byAdding: .day, value: -75, to: Date()) ?? Date(), timesKept: [Date(), Date(), Date(), Date(), Date(), Date()], timesDisliked: []),
                Habit(id: UUID(), name: "Hiking 🥾", dateCreated: Calendar.current.date(byAdding: .day, value: -111, to: Date()) ?? Date(), dateModified: Calendar.current.date(byAdding: .day, value: -111, to: Date()) ?? Date(), timesKept: [Date(), Date(), Date(), Date(), Date()], timesDisliked: []),
            ]
            currentSettings.importantDays = [
                ImportantDay(id: UUID(), name: "WWDC 2024", date: Calendar.current.date(from: DateComponents(timeZone: TimeZone(abbreviation: "PDT"), year: 2024, month: 6, day: 10, hour: 10, minute: 0)) ?? Date()),
                ImportantDay(id: UUID(), name: "WWDC 2023", date: Calendar.current.date(from: DateComponents(timeZone: TimeZone(abbreviation: "PDT"), year: 2023, month: 6, day: 5, hour: 10, minute: 0)) ?? Date()),
                ImportantDay(id: UUID(), name: "WWDC 2022", date: Calendar.current.date(from: DateComponents(timeZone: TimeZone(abbreviation: "PDT"), year: 2022, month: 6, day: 6, hour: 10, minute: 0)) ?? Date()),
            ]
        } catch {
            print("Error initializing default data: \(error)")
        }
    }
}
