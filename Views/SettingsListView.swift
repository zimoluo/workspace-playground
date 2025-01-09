//
//  SettingsListView.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

struct SettingsListView: View {
    @Bindable var settings: Settings

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Theme Settings") {
                    ThemeSettingsView(theme: settings.theme)
                }
            }
            .navigationTitle("Settings")
        }.onAppear {
            // Apply the navigation bar theme when the view appears
            NavigationAppearanceUtils.applyNavigationBarTheme(theme: settings.theme)
        }
        .onChange(of: settings.theme.primary) {
            NavigationAppearanceUtils.applyNavigationBarTheme(theme: settings.theme)
        }
    }
}
