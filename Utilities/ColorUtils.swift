//
//  ColorUtils.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

struct RGBAColor: Codable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double

    var color: Color {
        Color(red: self.red, green: self.green, blue: self.blue, opacity: self.alpha)
    }

    init(_ color: Color) {
        let uiColor = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.alpha = Double(a)
    }

    init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    private func toHSL() -> (h: Double, s: Double, l: Double) {
        let r = self.red
        let g = self.green
        let b = self.blue

        let maxC = max(r, g, b)
        let minC = min(r, g, b)
        let delta = maxC - minC

        // Lightness
        let l = (maxC + minC) / 2.0

        // Saturation
        var s: Double = 0
        if delta != 0 {
            s = delta / (1 - abs(2 * l - 1))
        }

        // Hue
        var h: Double = 0
        if delta != 0 {
            switch maxC {
            case r:
                h = ((g - b) / delta).truncatingRemainder(dividingBy: 6) * 60
            case g:
                h = ((b - r) / delta + 2) * 60
            case b:
                h = ((r - g) / delta + 4) * 60
            default:
                break
            }
        }

        // Normalize hue to [0,360)
        if h < 0 {
            h += 360
        }

        // Convert s, l to percentage [0...100] for consistency with old logic
        return (h: h, s: s * 100, l: l * 100)
    }

    private static func fromHSL(h: Double, s: Double, l: Double) -> RGBAColor {
        let s1 = s / 100.0
        let l1 = l / 100.0

        let c = (1 - abs(2 * l1 - 1)) * s1
        let x = c * (1 - abs((h / 60).truncatingRemainder(dividingBy: 2) - 1))
        let m = l1 - c / 2

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

        // Convert back to [0...1]
        return RGBAColor(
            red: r + m,
            green: g + m,
            blue: b + m,
            alpha: 1.0
        )
    }

    func shadeMap(numShades: Int = 17) -> (index: Int, shadeMap: [RGBAColor]) {
        // 1) Convert this color to HSL
        let (h, s, _) = self.toHSL()

        // 2) Generate an HSL list with varying lightness (and slightly adjusted saturation)
        var shadesHSL: [(h: Double, s: Double, l: Double)] = []
        for i in 0..<numShades {
            // Lightness ranges 94 down to ~6 (94 - 88) across numShades
            let newL = 94 - Double(i) * (88 / Double(numShades - 1))

            // Slight adjustment of saturation
            let newS = s < 0.01
                ? 0
                : min(100, max(0, s - 6 + (12 * Double(i)) / Double(numShades - 1)))

            shadesHSL.append((h: h, s: newS, l: newL))
        }

        // 3) Convert each HSL shade back to RGBAColor
        let shadesRGB = shadesHSL.map {
            RGBAColor.fromHSL(h: $0.h, s: $0.s, l: $0.l)
        }

        // 4) Find the shade closest to the original color in RGB space
        var minDistance = Double.infinity
        var closestIndex = -1

        for (index, shade) in shadesRGB.enumerated() {
            let distance = pow(shade.red - self.red, 2)
                + pow(shade.green - self.green, 2)
                + pow(shade.blue - self.blue, 2)
            if distance < minDistance {
                minDistance = distance
                closestIndex = index
            }
        }

        return (index: closestIndex, shadeMap: shadesRGB)
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
