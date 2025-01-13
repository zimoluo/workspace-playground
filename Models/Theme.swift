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

    var mainGradient: ColorGradient

    // Miscellaneous
    var readingBlur: Double

    var version: Int

    init(
        primary: RGBAColor = RGBAColor(red: 0.486, green: 0.176, blue: 0.071),
        secondary: RGBAColor = RGBAColor(red: 0.761, green: 0.255, blue: 0.047),
        tertiary: RGBAColor = RGBAColor(red: 1.0, green: 0.969, blue: 0.929),
        mainGradient: ColorGradient = ColorGradient(type: .linear, stops: [
            GradientStop(color: RGBAColor(red: 1, green: 0.929, blue: 0.898), position: 0), GradientStop(color: RGBAColor(red: 1, green: 0.984, blue: 0.894), position: 1)
        ], linearAttributes: LinearGradientAttributes(startPoint: CodableUnitPoint(from: .bottomLeading), endPoint: CodableUnitPoint(from: .topTrailing))),
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
        self.mainGradient = mainGradient
    }
}

enum PaletteCategory: String {
    case primary
    case secondary
    case tertiary
}

extension View {
    func themedForeground(using theme: Theme, in colorScheme: ColorScheme, level: Int = 0, category: PaletteCategory = .primary) -> some View {
        let foregroundColor = themeColor(
            from: theme,
            for: category,
            in: colorScheme,
            level: level
        )
        return self.foregroundColor(foregroundColor)
    }

    func themedBackground(using theme: Theme, in colorScheme: ColorScheme, level: Int, category: PaletteCategory = .primary) -> some View {
        let backgroundColor = themeColor(
            from: theme,
            for: category,
            in: colorScheme,
            level: level
        )
        return self.background(backgroundColor)
    }
}
