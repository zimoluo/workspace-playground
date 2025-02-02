import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct FancyMetallicGlobeView: View {
    @State private var meshPoints: [SIMD2<Float>] = MeshGradientHelper.generateMeshPoints()
    @State private var meshColors: [Color] = []
    @State private var hueRange: (Double, Double) = (0, 0)

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    private let animationDuration: Double = 2.0
    private let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Ellipse()
                    .fill(MeshGradient(width: 4, height: 4, points: meshPoints, colors: meshColors))
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 32)
                    .onAppear {
                        generateUniqueHueRange()
                        meshColors = MeshGradientHelper.generateMeshColors(hueRange: hueRange)
                    }
                    .onReceive(timer) { _ in
                        withAnimation(.linear(duration: animationDuration)) {
                            meshPoints = MeshGradientHelper.generateMeshPoints()
                            meshColors = MeshGradientHelper.generateMeshColors(hueRange: hueRange)
                        }
                    }

                MetallicBorder(lineWidth: min(geometry.size.width, geometry.size.height) * 0.066)
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 32)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func generateUniqueHueRange() {
        if let window = space.windows.first(where: { $0.id == windowId }) {
            let seed = window.id.uuidString.hashValue
            var generator = SeededRandomGenerator(seed: seed)

            let hueStart = Double.random(in: 0...0.8, using: &generator)
            let hueEnd = (hueStart + 0.2).truncatingRemainder(dividingBy: 1.0)
            hueRange = (hueStart, hueEnd)
        }
    }
}

enum MeshGradientHelper {
    private static let basePositions: [Float] = [0.0, 0.333, 0.667, 1.0]

    static func generateMeshPoints() -> [SIMD2<Float>] {
        var points: [SIMD2<Float>] = []
        for y in basePositions {
            for x in basePositions {
                let newX = (x == 0.0 || x == 1.0) ? x : min(max(x + Float.random(in: -0.12...0.12), 0.0), 1.0)
                let newY = (y == 0.0 || y == 1.0) ? y : min(max(y + Float.random(in: -0.12...0.12), 0.0), 1.0)
                points.append(SIMD2<Float>(newX, newY))
            }
        }
        return points
    }

    static func generateMeshColors(hueRange: (Double, Double)) -> [Color] {
        var colors: [Color] = []
        let (hueStart, hueEnd) = hueRange

        for _ in 0 ..< 16 {
            let hue = hueStart < hueEnd
                ? Double.random(in: hueStart...hueEnd)
                : Double.random(in: hueStart...1.0) + Double.random(in: 0.0...hueEnd)
            let saturation = Double.random(in: 0.5...0.85)
            let brightness = Double.random(in: 0.65...1.0)
            colors.append(Color(hue: hue, saturation: saturation, brightness: brightness))
        }
        return colors
    }
}

struct MetallicBorder: View {
    var lineWidth: CGFloat

    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.gray.opacity(0.8), location: 0.0),
                    .init(color: Color.white.opacity(0.9), location: 0.25),
                    .init(color: Color.gray.opacity(0.8), location: 0.5),
                    .init(color: Color.white.opacity(0.9), location: 0.75),
                    .init(color: Color.gray.opacity(0.8), location: 1.0)
                ]),
                center: .center,
                startAngle: .degrees(0),
                endAngle: .degrees(360)
            )
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.3),
                        Color.clear,
                        Color.white.opacity(0.3)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .blendMode(.overlay)
            )
            MetallicNoiseTexture()
                .blendMode(.overlay)
                .opacity(0.4)
        }
        .mask(
            Ellipse()
                .strokeBorder(lineWidth: lineWidth)
        )
    }
}

struct MetallicNoiseTexture: View {
    private let context = CIContext()
    private let noiseFilter = CIFilter.randomGenerator()
    private let colorControlsFilter = CIFilter.colorControls()

    var body: some View {
        GeometryReader { geometry in
            let rect = CGRect(origin: .zero, size: geometry.size)
            if let noiseImage = generateNoiseImage(in: rect) {
                Image(uiImage: noiseImage)
                    .resizable()
                    .scaledToFill()
            }
        }
    }

    func generateNoiseImage(in rect: CGRect) -> UIImage? {
        guard let noiseOutput = noiseFilter.outputImage?.cropped(to: rect) else {
            return nil
        }

        colorControlsFilter.inputImage = noiseOutput
        colorControlsFilter.saturation = 0

        guard let grayNoiseOutput = colorControlsFilter.outputImage else {
            return nil
        }

        if let cgImage = context.createCGImage(grayNoiseOutput, from: rect) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}

struct SeededRandomGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: Int) {
        self.state = UInt64(seed & 0x7FFFFFFFFFFFFFFF)
    }

    mutating func next() -> UInt64 {
        state ^= state >> 21
        state ^= state << 35
        state ^= state >> 4
        return state &* 2685821657736338717
    }
}
