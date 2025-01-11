//
//  Theme.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftData
import SwiftUI

@Model
class Theme: ObservableObject {
    @Attribute(.unique) var id: UUID

    var title: String
    var dateCreated: Date

    // Palette
    var primary: [Int]
    var secondary: [Int]
    var tertiary: [Int]

    // Gradients
    var pageGradient: [ColorGradient]
    var widgetGradient: [ColorGradient]

    // Miscellaneous
    var readingBlur: Double

    init(
        primary: [Int] = [124, 45, 18],
        secondary: [Int] = [194, 65, 12],
        tertiary: [Int] = [255, 247, 237],
        pageGradient: [ColorGradient] = [],
        widgetGradient: [ColorGradient] = [],
        readingBlur: Double = 0.0,
        title: String = "Default Theme"
    ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.pageGradient = pageGradient
        self.widgetGradient = widgetGradient
        self.readingBlur = readingBlur
        self.id = UUID()
        self.title = title
        self.dateCreated = Date()
    }
}

struct ColorGradient: Codable, Hashable {
    let colors: [[Int]] // RGB values for gradient stops
    let type: GradientType
    let angle: Double? // Only for linear gradients
}

enum GradientType: String, Codable {
    case linear
    case radial
    case conic
}

struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .init() // Provide a default theme
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

let textIndexMapLight: [Int: Int] = [
    0: 13,
    1: 10,
    2: 4,
    3: 0
]

let textIndexMapDark: [Int: Int] = [
    0: 0,
    1: 3,
    2: 7,
    3: 14
]

func getThemeColor(
    from theme: Theme,
    for category: String,
    in colorScheme: ColorScheme,
    level: Int,
    lightMap: [Int: Int] = textIndexMapLight,
    darkMap: [Int: Int] = textIndexMapDark
) -> Color {
    // Clamp the level between 0 and 3
    let clampedLevel = max(0, min(level, 3))

    // Get the input color based on the category
    let inputColor: [Int]
    switch category {
    case "primary":
        inputColor = theme.primary
    case "secondary":
        inputColor = theme.secondary
    case "tertiary":
        inputColor = theme.tertiary
    default:
        inputColor = theme.primary // Fallback to primary
    }

    // Generate the shade map
    let shadeMap = ColorUtils.generateShadeMap(inputColor: inputColor).shadeMap

    // Get the correct index for the color scheme
    let index = colorScheme == .light
        ? lightMap[clampedLevel] ?? 13
        : darkMap[clampedLevel] ?? 0

    // Return the color from the shade map
    return ColorUtils.colorFromRGB(shadeMap[index])
}

extension Text {
    func themed(using theme: Theme, in colorScheme: ColorScheme, level: Int = 0) -> some View {
        let textColor = getThemeColor(
            from: theme,
            for: "primary", // Using "primary" for text
            in: colorScheme,
            level: level
        )
        return self.foregroundColor(textColor)
    }
}

extension View {
    func themedBackground(using theme: Theme, in colorScheme: ColorScheme, level: Int, category: String = "secondary") -> some View {
        let backgroundColor = getThemeColor(
            from: theme,
            for: category, // Specify category (e.g., "secondary")
            in: colorScheme,
            level: level
        )
        return self.background(backgroundColor)
    }
}
