//
//  ThemeKey.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .init()
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

extension View {
    func themedTextColor() -> some View {
        modifier(ThemedTextModifier()) // Use a custom modifier to access the theme
    }
}

struct ThemedTextModifier: ViewModifier {
    @Environment(\.theme) var theme // Access the theme from the environment

    func body(content: Content) -> some View {
        content.foregroundColor(ColorUtils.colorFromRGB(theme.primary)) // Use theme.primary
    }
}

struct GlobalTextColorKey: EnvironmentKey {
    static let defaultValue: Color = .primary // Default SwiftUI text color
}

extension EnvironmentValues {
    var globalTextColor: Color {
        get { self[GlobalTextColorKey.self] }
        set { self[GlobalTextColorKey.self] = newValue }
    }
}
