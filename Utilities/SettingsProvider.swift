//
//  SettingsProvider.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/10/25.
//

import SwiftData
import SwiftUI

struct SettingsProvider<Content: View>: View {
    @Environment(\.modelContext) private var modelContext
    @Query var settings: [Settings]

    let content: (Theme, Settings) -> Content

    var body: some View {
        Group {
            if let currentSettings = settings.first {
                content(currentSettings.theme, currentSettings).task {
                    await initializeDefaultThemesIfNeeded()
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

    private func initializeDefaultThemesIfNeeded() async {
        let hasInitializedThemeDefaults = UserDefaults.standard.bool(forKey: "HasInitializedThemeDefaults")

        guard !hasInitializedThemeDefaults else {
            return
        }

        let defaultThemes: [Theme] = [
            Theme(
                primary: RGBAColor(red: 0.502, green: 0.031, blue: 0.188),
                secondary: RGBAColor(red: 0.769, green: 0.102, blue: 0.525),
                tertiary: RGBAColor(red: 0.812, green: 0.831, blue: 0.773),
                mainGradient: ColorGradient(
                    type: .linear,
                    stops: [
                        GradientStop(color: RGBAColor(red: 0.812, green: 0.831, blue: 0.773, alpha: 1.0), position: 0.0),
                        GradientStop(color: RGBAColor(red: 0.812, green: 0.831, blue: 0.773, alpha: 1.0), position: 0.2),
                        GradientStop(color: RGBAColor(red: 0.945, green: 0.561, blue: 0.811, alpha: 1.0), position: 0.2001),
                        GradientStop(color: RGBAColor(red: 0.945, green: 0.561, blue: 0.811, alpha: 1.0), position: 0.4),
                        GradientStop(color: RGBAColor(red: 0.937, green: 0.725, blue: 0.796, alpha: 1.0), position: 0.4001),
                        GradientStop(color: RGBAColor(red: 0.937, green: 0.725, blue: 0.796, alpha: 1.0), position: 0.6),
                        GradientStop(color: RGBAColor(red: 0.902, green: 0.678, blue: 0.925, alpha: 1.0), position: 0.6001),
                        GradientStop(color: RGBAColor(red: 0.902, green: 0.678, blue: 0.925, alpha: 1.0), position: 0.8),
                        GradientStop(color: RGBAColor(red: 0.761, green: 0.529, blue: 0.964, alpha: 1.0), position: 0.8001),
                        GradientStop(color: RGBAColor(red: 0.761, green: 0.529, blue: 0.964, alpha: 1.0), position: 1.0)
                    ],
                    linearAttributes: LinearGradientAttributes(
                        startPoint: CodableUnitPoint(x: 0.0, y: 0.833),
                        endPoint: CodableUnitPoint(x: 1.0, y: 0.167)
                    )
                )
            ),
            Theme(),
            Theme()
        ]

        for theme in defaultThemes {
            modelContext.insert(theme)
        }

        do {
            try modelContext.save()
            UserDefaults.standard.set(true, forKey: "HasInitializedThemeDefaults")
        } catch {
            print("Error initializing default data: \(error)")
        }
    }
}
