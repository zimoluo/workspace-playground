//
//  SettingsView.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/9/25.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) private var theme
    @Query private var settings: [Settings]

    var body: some View {
        Form {
            if let currentSettings = settings.first {
                Toggle("Enable Notifications", isOn: Binding(
                    get: { currentSettings.notificationsEnabled },
                    set: { currentSettings.notificationsEnabled = $0 }
                ))

                ColorPicker("Primary Color", selection: Binding(
                    get: { currentSettings.theme.primary.color },
                    set: { newColor in
                        currentSettings.theme.primary = RGBAColor(newColor)
                    }
                ), supportsOpacity: false)
                    .padding()

                ColorPicker("Secondary Color", selection: Binding(
                    get: { currentSettings.theme.secondary.color },
                    set: { newColor in
                        currentSettings.theme.secondary = RGBAColor(newColor)
                    }
                ), supportsOpacity: false)
                    .padding()

                ColorPicker("Tertiary Color", selection: Binding(
                    get: { currentSettings.theme.tertiary.color },
                    set: { newColor in
                        currentSettings.theme.tertiary = RGBAColor(newColor)
                    }
                ), supportsOpacity: false)
                    .padding()
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            ensureSettingsExist()
        }
    }

    private func ensureSettingsExist() {
        if settings.isEmpty {
            let defaultSettings = Settings()
            modelContext.insert(defaultSettings)
        }
    }
}
