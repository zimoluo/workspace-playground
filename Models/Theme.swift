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
    var contrast: [Int]

    // Gradients
    var pageGradient: [ColorGradient]
    var widgetGradient: [ColorGradient]

    // Miscellaneous
    var readingBlur: Double

    init(
        primary: [Int] = [124, 45, 18],
        secondary: [Int] = [194, 65, 12],
        contrast: [Int] = [255, 247, 237],
        pageGradient: [ColorGradient] = [],
        widgetGradient: [ColorGradient] = [],
        readingBlur: Double = 0.0,
        title: String = "Default Theme"
    ) {
        self.primary = primary
        self.secondary = secondary
        self.contrast = contrast
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
