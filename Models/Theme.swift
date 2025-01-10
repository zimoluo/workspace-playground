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

extension Text {
    func themed(using theme: Theme, in colorScheme: ColorScheme, level: Int = 0) -> some View {
        // Ensure the level is within bounds
        let clampedLevel = max(0, min(level, 3))

        // Generate the shade map
        let shadeMap = ColorUtils.generateShadeMap(inputColor: theme.primary)

        // Choose the index based on the color scheme and level
        let index = colorScheme == .light
            ? textIndexMapLight[clampedLevel] ?? 13
            : textIndexMapDark[clampedLevel] ?? 0

        let textColor = ColorUtils.colorFromRGB(shadeMap.shadeMap[index])

        return self.foregroundColor(textColor)
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
    3: 11
]
