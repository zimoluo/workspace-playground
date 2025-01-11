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

    let content: (Theme) -> Content

    var body: some View {
        Group {
            if let currentSettings = settings.first {
                content(currentSettings.theme)
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
}
