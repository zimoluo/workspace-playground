//
//  ColorGradient.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

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
