//
//  Theme.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftData
import SwiftUI

@Model
class Theme: ObservableObject, Equatable {
    @Attribute(.unique) var id: UUID

    var dateCreated: Date

    var primary: RGBAColor
    var secondary: RGBAColor
    var tertiary: RGBAColor

    var mainGradient: ColorGradient

    var version: Int

    var thumbnail: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [self.primary.shadeMap(numShades: 20).shadeMap[11].color, self.secondary.shadeMap(numShades: 20).shadeMap[8].color, self.tertiary.shadeMap(numShades: 20).shadeMap[4].color, self.primary.shadeMap(numShades: 20).shadeMap[1].color]),
            center: .center
        )
    }

    init(
        primary: RGBAColor = RGBAColor(red: 0.486, green: 0.176, blue: 0.071),
        secondary: RGBAColor = RGBAColor(red: 0.761, green: 0.255, blue: 0.047),
        tertiary: RGBAColor = RGBAColor(red: 1.0, green: 0.969, blue: 0.929),
        mainGradient: ColorGradient = ColorGradient(type: .linear, stops: [
            GradientStop(color: RGBAColor(red: 1, green: 0.929, blue: 0.898), position: 0), GradientStop(color: RGBAColor(red: 1, green: 0.984, blue: 0.894), position: 1)
        ], linearAttributes: LinearGradientAttributes(startPoint: CodableUnitPoint(from: .bottomLeading), endPoint: CodableUnitPoint(from: .topTrailing)))
    ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.mainGradient = mainGradient
        self.id = UUID()
        self.dateCreated = Date()
        self.version = 1
    }

    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return
            lhs.primary == rhs.primary &&
            lhs.secondary == rhs.secondary &&
            lhs.tertiary == rhs.tertiary &&
            lhs.mainGradient == rhs.mainGradient
    }

    func deepCopy() -> Theme {
        return Theme(
            primary: self.primary,
            secondary: self.secondary,
            tertiary: self.tertiary,
            mainGradient: self.mainGradient
        )
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
