import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct FancyMetallicGlobeView: View {
    @State private var meshPoints: [SIMD2<Float>] = MeshGradientHelper.generateMeshPoints()
    @State private var meshColors: [Color] = []
    @State private var hueRange: (Double, Double) = (0, 0)

    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject private var popUp: PopUp

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    private let animationDuration: Double = 2.0
    private let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()

    private let popUpHistoryKey = "popUpHistory"

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Ellipse()
                    .fill(MeshGradient(width: 4, height: 4, points: meshPoints, colors: meshColors))
                    .frame(width: geometry.size.width - 33, height: geometry.size.height - 33)
                    .onAppear {
                        generateUniqueHueRange()
                        meshColors = MeshGradientHelper.generateMeshColors(hueRange: hueRange, in: colorScheme)
                    }
                    .onReceive(timer) { _ in
                        withAnimation(.linear(duration: animationDuration)) {
                            meshPoints = MeshGradientHelper.generateMeshPoints()
                            meshColors = MeshGradientHelper.generateMeshColors(hueRange: hueRange, in: colorScheme)
                        }
                    }

                MetallicBorder(lineWidth: min(geometry.size.width, geometry.size.height) * 0.066)
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 32)
                    .contentShape(Ellipse())
                    .onTapGesture {
                        handleTap()
                    }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onTapGesture {
                handleTap()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func handleTap() {
        let allTypes: [PopUpType] = [.tips_menu, .tips_theme, .tips_technical, .tips_window]
        var history = getPopUpHistory()
        var available = allTypes.filter { !history.contains($0) }
        if available.isEmpty {
            history = []
            available = allTypes
        }
        if let chosen = available.randomElement() {
            popUp.type = chosen
            history.append(chosen)
            setPopUpHistory(history)
        }
    }

    private func getPopUpHistory() -> [PopUpType] {
        guard let windowIndex = space.windows.firstIndex(where: { $0.id == windowId }),
              let historyString = space.windows[windowIndex].data.saveData[popUpHistoryKey],
              let data = historyString.data(using: .utf8),
              let decoded = try? JSONDecoder().decode([PopUpType].self, from: data)
        else {
            return []
        }
        return decoded
    }

    private func setPopUpHistory(_ history: [PopUpType]) {
        guard let windowIndex = space.windows.firstIndex(where: { $0.id == windowId }) else { return }
        if let data = try? JSONEncoder().encode(history),
           let jsonString = String(data: data, encoding: .utf8)
        {
            space.windows[windowIndex].data.saveData[popUpHistoryKey] = jsonString
        }
    }

    private func generateUniqueHueRange() {
        if let window = space.windows.first(where: { $0.id == windowId }),
           let hueRangeString = window.data.saveData["hueRange"],
           let decodedHueRange = decodeHueRange(from: hueRangeString)
        {
            hueRange = decodedHueRange
        } else {
            let hueStart = Double.random(in: 0...0.8)
            let hueEnd = (hueStart + 0.2).truncatingRemainder(dividingBy: 1.0)
            hueRange = (hueStart, hueEnd)

            if let windowIndex = space.windows.firstIndex(where: { $0.id == windowId }) {
                space.windows[windowIndex].data.saveData["hueRange"] = encodeHueRange(hueRange)
            }
        }
    }

    private func encodeHueRange(_ hueRange: (Double, Double)) -> String {
        return "\(hueRange.0),\(hueRange.1)"
    }

    private func decodeHueRange(from string: String) -> (Double, Double)? {
        let components = string.split(separator: ",").compactMap { Double($0) }
        guard components.count == 2 else { return nil }
        return (components[0], components[1])
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

    static func generateMeshColors(hueRange: (Double, Double), in colorScheme: ColorScheme = .light) -> [Color] {
        var colors: [Color] = []
        let (hueStart, hueEnd) = hueRange

        for _ in 0 ..< 16 {
            let hue = hueStart < hueEnd
                ? Double.random(in: hueStart...hueEnd)
                : Double.random(in: hueStart...1.0) + Double.random(in: 0.0...hueEnd)
            let saturation = Double.random(in: 0.5...0.85)
            let brightness = Double.random(in: colorScheme == .light ? 0.65...1.0 : 0.4...0.75)
            colors.append(Color(hue: hue, saturation: saturation, brightness: brightness))
        }
        return colors
    }
}

struct MetallicBorder: View {
    var lineWidth: CGFloat
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(stops: [
                    .init(color: (colorScheme == .light ? Color.gray : Color(white: 0.12)).opacity(0.8), location: 0.0),
                    .init(color: (colorScheme == .light ? Color.white : Color(white: 0.33)).opacity(0.9), location: 0.25),
                    .init(color: (colorScheme == .light ? Color.gray : Color(white: 0.12)).opacity(0.8), location: 0.5),
                    .init(color: (colorScheme == .light ? Color.white : Color(white: 0.33)).opacity(0.9), location: 0.75),
                    .init(color: (colorScheme == .light ? Color.gray : Color(white: 0.12)).opacity(0.8), location: 1.0)
                ]),
                center: .center,
                startAngle: .degrees(0),
                endAngle: .degrees(360)
            )
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        (colorScheme == .light ? Color.white : Color(white: 0.36)).opacity(0.3),
                        Color.clear,
                        (colorScheme == .light ? Color.white : Color(white: 0.36)).opacity(0.3)
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
