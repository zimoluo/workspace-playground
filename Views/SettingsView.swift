//
//  SettingsView.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/9/25.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @Query private var settings: [Settings]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Form {
            if let currentSettings = settings.first {
                Toggle("Enable Notifications", isOn: Binding(
                    get: { currentSettings.notificationsEnabled },
                    set: { currentSettings.notificationsEnabled = $0 }
                ))

                ColorPicker("Primary Color", selection: Binding(
                    get: { ColorUtils.colorFromRGB(currentSettings.theme.primary) },
                    set: { newColor in
                        currentSettings.theme.primary = ColorUtils.rgbFromColor(newColor)
                    }
                ))
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
