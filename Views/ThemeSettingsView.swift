//
//  ThemeSettingsView.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

struct ThemeSettingsView: View {
    @Bindable var theme: Theme

    var body: some View {
        Form {
            Section(header: Text("Primary Color")) {
                ColorPicker("Primary", selection: Binding(
                    get: { ColorUtils.colorFromRGB(theme.primary) },
                    set: { theme.primary = ColorUtils.rgbFromColor($0) }
                ))
            }
            Section(header: Text("Secondary Color")) {
                ColorPicker("Secondary", selection: Binding(
                    get: { ColorUtils.colorFromRGB(theme.secondary) },
                    set: { theme.secondary = ColorUtils.rgbFromColor($0) }
                ))
            }
            Section(header: Text("Accent Color")) {
                ColorPicker("Accent", selection: Binding(
                    get: { ColorUtils.colorFromRGB(theme.accentColor) },
                    set: { theme.accentColor = ColorUtils.rgbFromColor($0) }
                ))
            }
        }
        .navigationTitle("Theme Settings")
    }
}
