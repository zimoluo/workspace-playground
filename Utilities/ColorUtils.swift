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

    static func generateShadeMap(inputColor: [Int], numShades: Int = 32) -> (index: Int, shadeMap: [[Int]]) {
        // Convert RGB to HSL
        let rgbToHsl: ([Int]) -> (h: Double, s: Double, l: Double) = { rgb in
            let r = Double(rgb[0]) / 255.0
            let g = Double(rgb[1]) / 255.0
            let b = Double(rgb[2]) / 255.0

            let max = [r, g, b].max()!
            let min = [r, g, b].min()!
            let delta = max - min

            let l = (max + min) / 2.0
            let s = l == 0 || l == 1 ? 0 : delta / (1 - abs(2 * l - 1))
            let h: Double

            if delta == 0 {
                h = 0
            } else if max == r {
                h = ((g - b) / delta).truncatingRemainder(dividingBy: 6.0) * 60.0
            } else if max == g {
                h = ((b - r) / delta + 2.0) * 60.0
            } else {
                h = ((r - g) / delta + 4.0) * 60.0
            }

            return (h < 0 ? h + 360 : h, s * 100, l * 100)
        }

        let hsl = rgbToHsl(inputColor)
        let h = hsl.h
        let s = hsl.s
        let l = hsl.l

        var shadesHSL: [(h: Double, s: Double, l: Double)] = []
        for i in 0..<numShades {
            let newL = 94 - Double(i) * (88 / Double(numShades - 1))
            let newS = s < 0.01 ? 0 : min(100, max(0, s - 6 + (12 * Double(i)) / Double(numShades - 1)))
            shadesHSL.append((h: h, s: newS, l: newL))
        }

        // Convert HSL back to RGB
        let hslToRgb: (Double, Double, Double) -> [Int] = { h, s, l in
            let s = s / 100.0
            let l = l / 100.0

            let c = (1 - abs(2 * l - 1)) * s
            let x = c * (1 - abs((h / 60.0).truncatingRemainder(dividingBy: 2) - 1))
            let m = l - c / 2.0

            let (r, g, b): (Double, Double, Double)
            switch h {
            case 0..<60:
                (r, g, b) = (c, x, 0)
            case 60..<120:
                (r, g, b) = (x, c, 0)
            case 120..<180:
                (r, g, b) = (0, c, x)
            case 180..<240:
                (r, g, b) = (0, x, c)
            case 240..<300:
                (r, g, b) = (x, 0, c)
            default:
                (r, g, b) = (c, 0, x)
            }

            return [Int((r + m) * 255), Int((g + m) * 255), Int((b + m) * 255)]
        }

        let shadesRGB = shadesHSL.map { hslToRgb($0.h, $0.s, $0.l) }

        // Find the closest shade to the input color
        var minDistance = Double.infinity
        var inputIndex = -1
        for (index, shade) in shadesRGB.enumerated() {
            let distance = zip(shade, inputColor).map { pow(Double($0 - $1), 2) }.reduce(0, +)
            if distance < minDistance {
                minDistance = distance
                inputIndex = index
            }
        }

        return (index: inputIndex, shadeMap: shadesRGB)
    }
}
