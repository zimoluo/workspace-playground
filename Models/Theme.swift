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
    // Palette
    var primary: [Int]
    var secondary: [Int]
    var contrast: [Int]

    // Gradients
    var pageGradient: [ColorGradient]
    var widgetGradient: [ColorGradient]

    // Miscellaneous
    var accentColor: [Int]
    var readingBlur: Double

    init(
        primary: [Int] = [255, 255, 255],
        secondary: [Int] = [200, 200, 200],
        contrast: [Int] = [0, 0, 0],
        pageGradient: [ColorGradient] = [],
        widgetGradient: [ColorGradient] = [],
        accentColor: [Int] = [0, 122, 255],
        readingBlur: Double = 0.0
    ) {
        self.primary = primary
        self.secondary = secondary
        self.contrast = contrast
        self.pageGradient = pageGradient
        self.widgetGradient = widgetGradient
        self.accentColor = accentColor
        self.readingBlur = readingBlur
    }
}
