import SwiftData
import SwiftUI

struct CodableUnitPoint: Codable {
    var x: Double
    var y: Double

    init(from point: UnitPoint) {
        self.x = point.x
        self.y = point.y
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
    let color: RGBAColor
    let position: Double

    func toSwiftUIStop() -> Gradient.Stop {
        Gradient.Stop(color: color.color, location: position)
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
    var startRadius: Double
    var endRadius: Double
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

    init() {
        self.type = .linear
        self.stops = [
            GradientStop(
                color: RGBAColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
                position: 0.0
            ),
            GradientStop(
                color: RGBAColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0),
                position: 1.0
            )
        ]
        self.linearAttributes = LinearGradientAttributes(
            startPoint: CodableUnitPoint(from: .top),
            endPoint: CodableUnitPoint(from: .bottom)
        )
        self.radialAttributes = RadialGradientAttributes(
            center: CodableUnitPoint(from: .center),
            startRadius: 0,
            endRadius: 100
        )
        self.angularAttributes = AngularGradientAttributes(
            center: CodableUnitPoint(from: .center),
            angle: CodableAngle(from: .zero)
        )
    }

    @ViewBuilder
    func toGradient() -> some View {
        switch type {
        case .linear:
            LinearGradient(
                gradient: Gradient(stops: stops.map { $0.toSwiftUIStop() }),
                startPoint: linearAttributes.startPoint.asUnitPoint,
                endPoint: linearAttributes.endPoint.asUnitPoint
            )

        case .radial:
            RadialGradient(
                gradient: Gradient(stops: stops.map { $0.toSwiftUIStop() }),
                center: radialAttributes.center.asUnitPoint,
                startRadius: radialAttributes.startRadius,
                endRadius: radialAttributes.endRadius
            )

        case .angular:
            AngularGradient(
                gradient: Gradient(stops: stops.map { $0.toSwiftUIStop() }),
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
