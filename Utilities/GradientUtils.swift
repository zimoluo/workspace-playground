import SwiftData
import SwiftUI

struct CodableUnitPoint: Codable {
    var x: Double
    var y: Double

    init(from point: UnitPoint) {
        self.x = point.x
        self.y = point.y
    }

    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }

    var asUnitPoint: UnitPoint {
        .init(x: x, y: y)
    }
}

struct CodableAngle: Codable {
    var degrees: Double

    init(from angle: Angle) {
        self.degrees = angle.degrees
    }

    var asAngle: Angle {
        .degrees(degrees)
    }
}

struct GradientStop: Codable {
    var color: RGBAColor
    var position: Double

    func toSwiftUIStop(in colorScheme: ColorScheme = .light) -> Gradient.Stop {
        Gradient.Stop(color: color.shadeMap(numShades: 28, saturationMultiplier: colorScheme == .light ? 0.92 : 0.6).shadeMap[colorScheme == .light ? 1 : 25].color, location: position)
    }
}

enum GradientType: String, Codable {
    case linear
    case radial
    case angular
}

struct LinearGradientAttributes: Codable {
    var startPoint: CodableUnitPoint
    var endPoint: CodableUnitPoint
}

/// Attributes for a radial gradient.
struct RadialGradientAttributes: Codable {
    var center: CodableUnitPoint
    var startRadiusFraction: Double
    var endRadiusFraction: Double
}

/// Attributes for an angular gradient.
struct AngularGradientAttributes: Codable {
    var center: CodableUnitPoint
    var angle: CodableAngle
}

struct ColorGradient: Codable {
    var type: GradientType
    var stops: [GradientStop]
    var linearAttributes: LinearGradientAttributes
    var radialAttributes: RadialGradientAttributes
    var angularAttributes: AngularGradientAttributes

    init(
        type: GradientType = .linear,
        stops: [GradientStop] = [
            GradientStop(
                color: RGBAColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
                position: 0.0
            ),
            GradientStop(
                color: RGBAColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0),
                position: 1.0
            )
        ],
        linearAttributes: LinearGradientAttributes = LinearGradientAttributes(
            startPoint: CodableUnitPoint(from: .top),
            endPoint: CodableUnitPoint(from: .bottom)
        ),
        radialAttributes: RadialGradientAttributes = RadialGradientAttributes(
            center: CodableUnitPoint(from: .center),
            startRadiusFraction: 0.0,
            endRadiusFraction: 1.0
        ),
        angularAttributes: AngularGradientAttributes = AngularGradientAttributes(
            center: CodableUnitPoint(from: .center),
            angle: CodableAngle(from: .zero)
        )
    ) {
        self.type = type
        self.stops = stops
        self.linearAttributes = linearAttributes
        self.radialAttributes = radialAttributes
        self.angularAttributes = angularAttributes
    }

    @ViewBuilder
    func toGradient(in colorScheme: ColorScheme = .light) -> some View {
        let sortedStops = stops.sorted { $0.position < $1.position }

        switch type {
        case .linear:
            LinearGradient(
                gradient: Gradient(stops: sortedStops.map { $0.toSwiftUIStop(in: colorScheme) }),
                startPoint: linearAttributes.startPoint.asUnitPoint,
                endPoint: linearAttributes.endPoint.asUnitPoint
            )

        case .radial:
            EllipticalGradient(
                gradient: Gradient(stops: sortedStops.map { $0.toSwiftUIStop(in: colorScheme) }),
                center: radialAttributes.center.asUnitPoint,
                startRadiusFraction: radialAttributes.startRadiusFraction,
                endRadiusFraction: radialAttributes.endRadiusFraction
            )

        case .angular:
            AngularGradient(
                gradient: Gradient(stops: sortedStops.map { $0.toSwiftUIStop(in: colorScheme) }),
                center: angularAttributes.center.asUnitPoint,
                angle: angularAttributes.angle.asAngle
            )
        }
    }

    @ViewBuilder
    private func fallbackGradient() -> some View {
        Color.clear
    }
}
