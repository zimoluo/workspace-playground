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
    var primary: RGBAColor
    var secondary: RGBAColor
    var tertiary: RGBAColor

    // Miscellaneous
    var readingBlur: Double

    var version: Int

    init(
        primary: RGBAColor = RGBAColor(red: 0.486, green: 0.176, blue: 0.071),
        secondary: RGBAColor = RGBAColor(red: 0.761, green: 0.255, blue: 0.047),
        tertiary: RGBAColor = RGBAColor(red: 1.0, green: 0.969, blue: 0.929),
        readingBlur: Double = 0.0,
        title: String = "Default Theme"
    ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.readingBlur = readingBlur
        self.id = UUID()
        self.title = title
        self.dateCreated = Date()
        self.version = 1
    }
}

func themeColor(
    from theme: Theme,
    for category: String,
    in colorScheme: ColorScheme,
    level: Int,
    lightMap: [Int: Int] = textIndexMapLight,
    darkMap: [Int: Int] = textIndexMapDark
) -> Color {
    let clampedLevel = max(0, min(level, 3))

    let inputColor: RGBAColor
    switch category {
    case "primary":
        inputColor = theme.primary
    case "secondary":
        inputColor = theme.secondary
    case "tertiary":
        inputColor = theme.tertiary
    default:
        inputColor = theme.primary
    }

    let index = colorScheme == .light
        ? lightMap[clampedLevel] ?? 13
        : darkMap[clampedLevel] ?? 0

    return inputColor.shadeMap().shadeMap[index].color
}

extension Text {
    func themed(using theme: Theme, in colorScheme: ColorScheme, level: Int = 0) -> some View {
        let textColor = themeColor(
            from: theme,
            for: "primary",
            in: colorScheme,
            level: level
        )
        return self.foregroundColor(textColor)
    }
}

extension View {
    func themedBackground(using theme: Theme, in colorScheme: ColorScheme, level: Int, category: String = "secondary") -> some View {
        let backgroundColor = themeColor(
            from: theme,
            for: category, // Specify category (e.g., "secondary")
            in: colorScheme,
            level: level
        )
        return self.background(backgroundColor)
    }
}
