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
                Picker("Theme", selection: Binding(
                    get: { currentSettings.theme },
                    set: { currentSettings.theme = $0 }
                )) {
                    Text("Light").tag("Light")
                    Text("Dark").tag("Dark")
                }
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
