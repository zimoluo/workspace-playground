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
        self.toColor()
    }

    func toColor(opacity: Double? = nil) -> Color {
        Color(
            red: self.red,
            green: self.green,
            blue: self.blue,
            opacity: opacity ?? self.alpha
        )
    }

    func toShadow(opacityMultiplier: Double = 1) -> Color {
        self.shadeMap(numShades: 16).shadeMap[12].toColor(opacity: 0.18 * opacityMultiplier)
    }

    func toThemeGradientColor(in colorScheme: ColorScheme = .light) -> Color {
        self.shadeMap(numShades: 28, saturationMultiplier: colorScheme == .light ? 0.92 : 0.6).shadeMap[colorScheme == .light ? 1 : 25].color
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

    static func randomBright() -> RGBAColor {
        let hue = Double.random(in: 0...1)
        let brightness = Double.random(in: 0.5...0.7)
        let saturation = Double.random(in: 0.6...0.95)
        let uiColor = UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1.0)
        let color = RGBAColor(Color(uiColor))
        return color
    }

    func secondaryColor() -> RGBAColor {
        let hueComplement = (hue + 0.5).truncatingRemainder(dividingBy: 1.0) // Complementary hue
        let saturationAdjusted = max(0.4, min(0.9, saturation * 0.8)) // Adjust saturation slightly for harmony
        let brightnessAdjusted = max(0.6, brightness * 0.9) // Slightly adjust brightness for contrast
        return RGBAColor.fromHSB(hue: hueComplement, saturation: saturationAdjusted, brightness: brightnessAdjusted)
    }

    /// Calculates the tertiary key color as a balance between primary and secondary.
    func tertiaryColor() -> RGBAColor {
        let hueAnalogous = (hue + 0.08).truncatingRemainder(dividingBy: 1.0) // Analogous hue offset
        let saturationAdjusted = max(0.5, saturation * 0.7) // Further adjust saturation for subtlety
        let brightnessAdjusted = max(0.5, brightness * 0.8) // Slight dimming for harmony
        return RGBAColor.fromHSB(hue: hueAnalogous, saturation: saturationAdjusted, brightness: brightnessAdjusted)
    }

    /// Helper to create an RGBAColor from HSB values.
    static func fromHSB(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1.0) -> RGBAColor {
        let uiColor = UIColor(
            hue: CGFloat(hue),
            saturation: CGFloat(saturation),
            brightness: CGFloat(brightness),
            alpha: CGFloat(alpha)
        )
        return RGBAColor(Color(uiColor))
    }

    /// Decomposes the color to HSB for manipulation.
    private var hue: Double {
        let uiColor = UIColor(Color(red: red, green: green, blue: blue, opacity: alpha))
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return Double(h)
    }

    private var saturation: Double {
        let uiColor = UIColor(Color(red: red, green: green, blue: blue, opacity: alpha))
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return Double(s)
    }

    private var brightness: Double {
        let uiColor = UIColor(Color(red: red, green: green, blue: blue, opacity: alpha))
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return Double(b)
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
                h = ((g - b) / delta).truncatingRemainder(dividingBy: 6) / 6.0
            case g:
                h = ((b - r) / delta + 2) / 6.0
            case b:
                h = ((r - g) / delta + 4) / 6.0
            default:
                break
            }
        }

        // Normalize hue to [0, 1)
        if h < 0 {
            h += 1.0
        }

        return (h: h, s: s, l: l)
    }

    private static func fromHSL(h: Double, s: Double, l: Double) -> RGBAColor {
        let c = (1 - abs(2 * l - 1)) * s
        let x = c * (1 - abs((h * 6).truncatingRemainder(dividingBy: 2) - 1))
        let m = l - c / 2

        let (r, g, b): (Double, Double, Double)
        switch h {
        case 0..<1 / 6:
            (r, g, b) = (c, x, 0)
        case 1 / 6..<2 / 6:
            (r, g, b) = (x, c, 0)
        case 2 / 6..<3 / 6:
            (r, g, b) = (0, c, x)
        case 3 / 6..<4 / 6:
            (r, g, b) = (0, x, c)
        case 4 / 6..<5 / 6:
            (r, g, b) = (x, 0, c)
        default:
            (r, g, b) = (c, 0, x)
        }

        return RGBAColor(
            red: r + m,
            green: g + m,
            blue: b + m,
            alpha: 1.0
        )
    }

    func shadeMap(numShades: Int = 32, hueMultiplier: Double = 1.0, saturationMultiplier: Double = 1.0) -> (index: Int, shadeMap: [RGBAColor]) {
        // Convert this color to HSL
        let (h, s, _) = self.toHSL()
        let modifiedS = s * saturationMultiplier
        var modifiedH = h * hueMultiplier
        modifiedH = modifiedH.truncatingRemainder(dividingBy: 1.0)
        if modifiedH < 0 {
            modifiedH += 1.0
        }

        var shadesHSL: [(h: Double, s: Double, l: Double)] = []
        for i in 0..<numShades {
            let newL = 0.94 - Double(i) * (0.88 / Double(numShades - 1))
            let newS = modifiedS < 0.0005
                ? 0
                : min(1.0, max(0.0, modifiedS - 0.06 + (0.12 * Double(i)) / Double(numShades - 1)))

            shadesHSL.append((h: modifiedH, s: newS, l: newL))
        }

        let shadesRGB = shadesHSL.map {
            RGBAColor.fromHSL(h: $0.h, s: $0.s, l: $0.l)
        }

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

let shadeIndexMapLight: [Int: Int] = [
    0: 28,
    1: 21,
    2: 10,
    3: 3,
    4: 2,
    5: 0
]

let shadeIndexMapDark: [Int: Int] = [
    0: 0,
    1: 6,
    2: 14,
    3: 19,
    4: 26,
    5: 29
]

func themeColor(
    from theme: Theme,
    for category: PaletteCategory = .primary,
    in colorScheme: ColorScheme,
    level: Int = 0,
    lightMap: [Int: Int] = shadeIndexMapLight,
    darkMap: [Int: Int] = shadeIndexMapDark
) -> Color {
    let clampedLevel = max(0, min(level, 5))
    var saturationMultiplier = 1.0

    let inputColor: RGBAColor
    switch category {
    case .primary:
        inputColor = theme.primary
        saturationMultiplier *= 0.85
    case .secondary:
        inputColor = theme.secondary
    case .tertiary:
        inputColor = theme.tertiary
    }

    if colorScheme == .dark {
        saturationMultiplier *= 0.6
    }

    let index = colorScheme == .light
        ? lightMap[clampedLevel] ?? 13
        : darkMap[clampedLevel] ?? 0

    return inputColor.shadeMap(saturationMultiplier: saturationMultiplier).shadeMap[index].color
}
