//
//  GradientUtils.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

struct ColorGradient {
    let keyColor1: RGBAColor
    let keyColor2: RGBAColor
    let type: GradientType
    let attributes: GradientAttributes
}

enum GradientType: String, Codable {
    case linear
    case radial
    case angular
}

enum GradientAttributes {
    case linear(startPoint: UnitPoint, endPoint: UnitPoint)
    case radial(center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat)
    case angular(center: UnitPoint, angle: Angle)
}

extension ColorGradient {
    func toGradient() -> AnyView {
        let gradient = Gradient(colors: [keyColor1.color, keyColor2.color])

        switch attributes {
        case .linear(let startPoint, let endPoint):
            return AnyView(
                LinearGradient(
                    gradient: gradient,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
        case .radial(let center, let startRadius, let endRadius):
            return AnyView(
                RadialGradient(
                    gradient: gradient,
                    center: center,
                    startRadius: startRadius,
                    endRadius: endRadius
                )
            )
        case .angular(let center, let angle):
            return AnyView(
                AngularGradient(
                    gradient: gradient,
                    center: center,
                    angle: angle
                )
            )
        }
    }
}
