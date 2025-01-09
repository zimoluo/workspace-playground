//
//  ColorUtils.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

enum ColorUtils {
    static func colorFromRGB(_ rgb: [Int]) -> Color {
        Color(red: Double(rgb[0]) / 255, green: Double(rgb[1]) / 255, blue: Double(rgb[2]) / 255)
    }

    static func rgbFromColor(_ color: Color) -> [Int] {
        guard let components = color.cgColor?.components, components.count >= 3 else { return [0, 0, 0] }
        return components.prefix(3).map { Int($0 * 255) }
    }

    static func uiColorFromRGB(_ rgb: [Int]) -> UIColor {
        return UIColor(red: CGFloat(rgb[0]) / 255.0,
                       green: CGFloat(rgb[1]) / 255.0,
                       blue: CGFloat(rgb[2]) / 255.0,
                       alpha: 1.0)
    }
}
