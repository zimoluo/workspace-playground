import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct FancyMetallicGlobeView: View {
    @State private var hue: CGFloat = 0

    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject private var popUp: PopUp

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    private let popUpHistoryKey = "popUpHistory"

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AnimatedMeshBackground(baseHue: hue)
                    .frame(width: geometry.size.width - 33, height: geometry.size.height - 33)
                    .clipShape(Ellipse())
                    .onAppear {
                        generateUniqueHue()
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

    private func generateUniqueHue() {
        if let window = space.windows.first(where: { $0.id == windowId }),
           let hueString = window.data.saveData["hue"]
        {
            hue = Double(hueString) ?? 0
        } else {
            let randomHue: Double = .random(in: 0 ... 1)

            if let windowIndex = space.windows.firstIndex(where: { $0.id == windowId }) {
                space.windows[windowIndex].data.saveData["hue"] = "\(randomHue)"
            }

            hue = randomHue
        }
    }
}

struct AnimatedMeshBackground: View {
    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    let baseHue: CGFloat

    @State var salt: Int = 0

    let cycleDuration: TimeInterval = 2.13

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TimelineView(.animation) { timeline in
            let currentTime = timeline.date.timeIntervalSinceReferenceDate
            let points = computeMeshPoints(time: currentTime)
            let colors: [Color] = (0..<16).map { i in
                let variation = computeColorVariation(for: i, time: currentTime)
                let newHue = (baseHue + variation.hueOffset).truncatingRemainder(dividingBy: 1.0)
                let newBrightness = colorScheme == .light ? variation.brightness : (0.8857 * variation.brightness - 0.1957)
                return Color(hue: Double(newHue), saturation: Double(variation.saturation), brightness: Double(newBrightness))
            }
            MeshGradient(width: 4, height: 4, points: points, colors: colors)
        }
        .ignoresSafeArea()
        .onAppear {
            if let window = space.windows.first(where: { $0.id == windowId }),
               let saltString = window.data.saveData["animatedMeshBackgroundSalt"]
            {
                salt = Int(saltString) ?? .random(in: 0 ... 2147483647)
            } else {
                let randomSalt: Int = .random(in: 0 ... 2147483647)

                if let windowIndex = space.windows.firstIndex(where: { $0.id == windowId }) {
                    space.windows[windowIndex].data.saveData["animatedMeshBackgroundSalt"] = "\(salt)"
                }

                salt = randomSalt
            }
        }
    }

    func computeMeshPoints(time: TimeInterval) -> [SIMD2<Float>] {
        let currentPeriod = Int(time / cycleDuration)
        let fraction = Float((time.truncatingRemainder(dividingBy: cycleDuration)) / cycleDuration)
        var points: [SIMD2<Float>] = []
        for row in 0..<4 {
            for col in 0..<4 {
                let baseX = Float(col) / 3.0
                let baseY = Float(row) / 3.0
                if row == 0 || row == 3 || col == 0 || col == 3 {
                    points.append(SIMD2<Float>(baseX, baseY))
                } else {
                    let offsetCurrent = randomOffset(row: row, col: col, period: currentPeriod)
                    let offsetNext = randomOffset(row: row, col: col, period: currentPeriod + 1)
                    let interpOffset = offsetCurrent + (offsetNext - offsetCurrent) * fraction
                    let perturbedX = baseX + interpOffset.x
                    let perturbedY = baseY + interpOffset.y
                    points.append(SIMD2<Float>(min(max(perturbedX, 0), 1), min(max(perturbedY, 0), 1)))
                }
            }
        }
        return points
    }

    func randomOffset(row: Int, col: Int, period: Int) -> SIMD2<Float> {
        let baseSeed = salt + period * 1000 + row * 100 + col * 10
        let randomX = pseudoRandom(seed: baseSeed + 1)
        let randomY = pseudoRandom(seed: baseSeed + 2)
        let amplitude: Float = 0.12
        let offsetX = Float(randomX) * 2 * amplitude - amplitude
        let offsetY = Float(randomY) * 2 * amplitude - amplitude
        return SIMD2<Float>(offsetX, offsetY)
    }

    func computeColorVariation(for cell: Int, time: TimeInterval) -> ColorVariation {
        let currentPeriod = Int(time / cycleDuration)
        let fraction = CGFloat((time.truncatingRemainder(dividingBy: cycleDuration)) / cycleDuration)
        let currentVar = randomColorVariation(for: cell, period: currentPeriod)
        let nextVar = randomColorVariation(for: cell, period: currentPeriod + 1)
        let interpHueOffset = currentVar.hueOffset + (nextVar.hueOffset - currentVar.hueOffset) * fraction
        let interpSaturation = currentVar.saturation + (nextVar.saturation - currentVar.saturation) * fraction
        let interpBrightness = currentVar.brightness + (nextVar.brightness - currentVar.brightness) * fraction
        return ColorVariation(hueOffset: interpHueOffset, saturation: interpSaturation, brightness: interpBrightness)
    }

    func randomColorVariation(for cell: Int, period: Int) -> ColorVariation {
        let baseSeed = salt + period * 1000 + cell * 100
        let randomHue = pseudoRandom(seed: baseSeed + 1)
        let randomSat = pseudoRandom(seed: baseSeed + 2)
        let randomBri = pseudoRandom(seed: baseSeed + 3)
        let hueOffset = CGFloat(randomHue) * 0.2 - 0.1
        let saturation = 0.5 + (0.85 - 0.5) * CGFloat(randomSat)
        let brightness = 0.65 + (1.0 - 0.65) * CGFloat(randomBri)
        return ColorVariation(hueOffset: hueOffset, saturation: saturation, brightness: brightness)
    }

    func pseudoRandom(seed: Int) -> Double {
        var value = seed
        value = (value ^ 61) ^ (value >> 16)
        value = value &* 9
        value = value ^ (value >> 4)
        value = value &* 0x27d4eb2d
        value = value ^ (value >> 15)
        return Double(value & 0x7fffffff) / Double(0x7fffffff)
    }

    struct ColorVariation {
        var hueOffset: CGFloat
        var saturation: CGFloat
        var brightness: CGFloat
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
