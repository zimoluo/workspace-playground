import SwiftData
import SwiftUI

struct CodableUnitPoint: Codable, Equatable {
    var x: CGFloat
    var y: CGFloat

    init(from point: UnitPoint) {
        self.x = point.x
        self.y = point.y
    }

    init(x: CGFloat = 0, y: CGFloat = 0) {
        self.x = x
        self.y = y
    }

    var asUnitPoint: UnitPoint {
        .init(x: x, y: y)
    }

    static func == (lhs: CodableUnitPoint, rhs: CodableUnitPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct CodableAngle: Codable, Equatable {
    var degrees: CGFloat

    init(from angle: Angle) {
        self.degrees = angle.degrees
    }

    var asAngle: Angle {
        .degrees(degrees)
    }

    static func == (lhs: CodableAngle, rhs: CodableAngle) -> Bool {
        return lhs.degrees == rhs.degrees
    }
}

struct GradientStop: Codable, Equatable {
    var color: RGBAColor
    var position: CGFloat

    func toSwiftUIStop(in colorScheme: ColorScheme = .light) -> Gradient.Stop {
        Gradient.Stop(color: color.toThemeGradientColor(in: colorScheme), location: position)
    }

    static func == (lhs: GradientStop, rhs: GradientStop) -> Bool {
        return lhs.color == rhs.color &&
            lhs.position == rhs.position
    }
}

enum GradientType: String, Codable {
    case linear
    case radial
    case angular
    case mesh

    var symbol: String {
        switch self {
        case .linear: return "LinearGradient"
        case .radial: return "RadialGradient"
        case .angular: return "AngularGradient"
        case .mesh: return "MeshGradient"
        }
    }

    var title: String {
        switch self {
        case .linear: return "Linear"
        case .radial: return "Radial"
        case .angular: return "Conic"
        case .mesh: return "Mesh"
        }
    }

    static var allCases: [GradientType] {
        [.linear, .radial, .angular, .mesh]
    }
}

struct LinearGradientAttributes: Codable, Equatable {
    var startPoint: CodableUnitPoint
    var endPoint: CodableUnitPoint

    static func == (lhs: LinearGradientAttributes, rhs: LinearGradientAttributes) -> Bool {
        return lhs.startPoint == rhs.startPoint &&
            lhs.endPoint == rhs.endPoint
    }
}

struct RadialGradientAttributes: Codable, Equatable {
    var center: CodableUnitPoint
    var edgePoint: CodableUnitPoint

    static func == (lhs: RadialGradientAttributes, rhs: RadialGradientAttributes) -> Bool {
        return lhs.center == rhs.center &&
            lhs.edgePoint == rhs.edgePoint
    }
}

struct AngularGradientAttributes: Codable, Equatable {
    var center: CodableUnitPoint
    var angle: CodableAngle

    static func == (lhs: AngularGradientAttributes, rhs: AngularGradientAttributes) -> Bool {
        return lhs.center == rhs.center &&
            lhs.angle == rhs.angle
    }
}

struct MeshGradientAttributes: Codable, Equatable {
    var width: Int
    var height: Int
    var points: [SIMD2<Float>]
    var colors: [RGBAColor]

    static func == (lhs: MeshGradientAttributes, rhs: MeshGradientAttributes) -> Bool {
        return lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.points == rhs.points &&
            lhs.colors == rhs.colors
    }
}

struct ColorGradient: Codable, Equatable {
    var type: GradientType
    var stops: [GradientStop]
    var linearAttributes: LinearGradientAttributes
    var radialAttributes: RadialGradientAttributes
    var angularAttributes: AngularGradientAttributes
    var meshAttributes: MeshGradientAttributes

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
            edgePoint: CodableUnitPoint(from: .top)
        ),
        angularAttributes: AngularGradientAttributes = AngularGradientAttributes(
            center: CodableUnitPoint(from: .center),
            angle: CodableAngle(from: .zero)
        ),
        meshAttributes: MeshGradientAttributes = MeshGradientAttributes(width: 3, height: 3, points: [[0.0, 0.0], [0.5, 0.0], [1.0, 0.0], [0.0, 0.5], [0.5, 0.5], [1.0, 0.5], [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]], colors: [RGBAColor(.red), RGBAColor(.red), RGBAColor(.red), RGBAColor(.green), RGBAColor(.green), RGBAColor(.green), RGBAColor(.blue), RGBAColor(.blue), RGBAColor(.blue)])
    ) {
        self.type = type
        self.stops = stops
        self.linearAttributes = linearAttributes
        self.radialAttributes = radialAttributes
        self.angularAttributes = angularAttributes
        self.meshAttributes = meshAttributes
    }

    static func == (lhs: ColorGradient, rhs: ColorGradient) -> Bool {
        return lhs.type == rhs.type &&
            lhs.stops == rhs.stops &&
            lhs.linearAttributes == rhs.linearAttributes &&
            lhs.radialAttributes == rhs.radialAttributes &&
            lhs.angularAttributes == rhs.angularAttributes &&
            lhs.meshAttributes == rhs.meshAttributes
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
                startRadiusFraction: 0,
                endRadiusFraction: {
                    let center = radialAttributes.center
                    let edgePoint = radialAttributes.edgePoint
                    let dx = edgePoint.x - center.x
                    let dy = edgePoint.y - center.y
                    return sqrt(dx * dx + dy * dy)
                }()
            )

        case .angular:
            AngularGradient(
                gradient: Gradient(stops: sortedStops.map { $0.toSwiftUIStop(in: colorScheme) }),
                center: angularAttributes.center.asUnitPoint,
                angle: angularAttributes.angle.asAngle
            )

        case .mesh:
            let requiredCount = meshAttributes.width * meshAttributes.height
            let points = meshAttributes.points.prefix(requiredCount) +
                Array(repeating: SIMD2<Float>(0.5, 0.5), count: max(0, requiredCount - meshAttributes.points.count))

            let colors = meshAttributes.colors.prefix(requiredCount) +
                Array(repeating: RGBAColor(.white), count: max(0, requiredCount - meshAttributes.colors.count))

            MeshGradient(
                width: meshAttributes.width,
                height: meshAttributes.height,
                points: points.map { $0 },
                colors: colors.map { $0.toThemeGradientColor(in: colorScheme) },
                background: colors[0].toThemeGradientColor(in: colorScheme)
            )
        }
    }

    @ViewBuilder
    private func fallbackGradient() -> some View {
        Color.clear
    }
}
