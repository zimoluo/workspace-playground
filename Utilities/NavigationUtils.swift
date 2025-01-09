//
//  NavigationAppearanceUtils.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

enum NavigationAppearanceUtils {
    static func applyNavigationBarTheme(theme: Theme) {
        let appearance = UINavigationBarAppearance()

        // Set title text color using the theme's primary color
        let primaryUIColor = ColorUtils.uiColorFromRGB(theme.primary)
        appearance.titleTextAttributes = [.foregroundColor: primaryUIColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: primaryUIColor]

        // Apply appearance to the navigation bar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        // Set the tint color for navigation bar items (e.g., back button)
        UINavigationBar.appearance().tintColor = primaryUIColor
    }
}
