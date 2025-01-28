import SwiftData
import SwiftUI

struct Window: Codable {
    var id: UUID

    var state: WindowState
    var data: WindowData

    init(
        state: WindowState = .init(),
        data: WindowData = .init()
    ) {
        self.id = UUID()
        self.data = WindowData.applyDefaults(baseData: data)
        self.state = WindowState.applyDefaults(type: data.type, baseState: state)
    }
}

// WindowState stores the dimension and position of the window. Due to its changeable nature, it's managed by windows themselves, but it's also stored in model context in order to persist. Windows will choose specific occasions, like right after finishing dragging, to sync its version of WindowState with the model context. This means individual windows only need its own copy of state and its UUID which is used to link itself to the model context.
// In short, WindowState is kept and managed by windows themselves and only synced to the model context at select occasions.
// UPDATE: Looks like model context is able to manage this efficiently. So I might as well remove this distinction. Consider window state just another form of window data. It will now be directly managed by the model context.
struct WindowState: Codable {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 100
    var height: CGFloat = 100

    static func applyDefaults(type: WindowType, baseState: WindowState) -> WindowState {
        var updatedState = baseState
        updatedState.width = type.defaultSize.width
        updatedState.height = type.defaultSize.height
        return updatedState
    }
}

// WindowData is directly tied to the model context, meaning that individual windows won't keep their own version of the window data, and every change happens directly at the app data level. It's still mutable, but much less needed compared to WindowState, so the performance impact is minimal.
// In short, WindowData is only kept by the model context. Windows directly read WindowData from model context and makes changes on the model context directly.
struct WindowData: Codable {
    var type: WindowType
    var saveData: [String: String]
    var minHeight: CGFloat
    var minWidth: CGFloat
    var maxHeight: CGFloat
    var maxWidth: CGFloat
    var minAspectRatio: CGFloat
    var maxAspectRatio: CGFloat
    var layer: Int

    init(
        type: WindowType = .blank,
        saveData: [String: String] = [:],
        minHeight: CGFloat = 0,
        minWidth: CGFloat = 0,
        maxHeight: CGFloat = 1_000_000_000,
        maxWidth: CGFloat = 1_000_000_000,
        minAspectRatio: CGFloat = 0,
        maxAspectRatio: CGFloat = 1_000_000_000,
        layer: Int = 0
    ) {
        self.type = type
        self.saveData = saveData
        self.minHeight = minHeight
        self.minWidth = minWidth
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.minAspectRatio = minAspectRatio
        self.maxAspectRatio = maxAspectRatio
        self.layer = layer
    }

    static func applyDefaults(baseData: WindowData) -> WindowData {
        var updatedData = baseData

        switch updatedData.type {
        case .notes:
            updatedData.maxHeight = 800
            updatedData.maxWidth = 800
            updatedData.minHeight = 200
            updatedData.minWidth = 200
        case .blank:
            updatedData.maxHeight = 800
            updatedData.maxWidth = 800
            updatedData.minHeight = 100
            updatedData.minWidth = 100
        case .clock:
            updatedData.maxHeight = 300
            updatedData.maxWidth = 300
            updatedData.minHeight = 150
            updatedData.minWidth = 150
            updatedData.minAspectRatio = (sqrt(5) - 1) / 2
            updatedData.maxAspectRatio = (sqrt(5) + 1) / 2
        case .digitalClock:
            updatedData.maxHeight = 420
            updatedData.maxWidth = 420
            updatedData.minHeight = 120
            updatedData.minWidth = 120
            updatedData.minAspectRatio = 1
            updatedData.maxAspectRatio = 2
        case .themeMaker:
            updatedData.maxHeight = 676
            updatedData.maxWidth = 960
            updatedData.minHeight = 676
            updatedData.minWidth = 640
        case .stopwatch:
            updatedData.maxWidth = 420
            updatedData.minWidth = 280
            updatedData.maxHeight = 600
            updatedData.minHeight = 340
        }

        return updatedData
    }
}

enum WindowType: String, Codable, CaseIterable {
    case clock
    case stopwatch
    case digitalClock
    case notes
    case blank
    case themeMaker

    var defaultSize: (width: CGFloat, height: CGFloat) {
        switch self {
        case .blank: return (180, 180)
        case .notes: return (220, 280)
        case .clock: return (190, 190)
        case .digitalClock: return (240, 150)
        case .themeMaker: return (700, 676)
        case .stopwatch: return (300, 360)
        }
    }

    var glyph: WindowGlyph {
        switch self {
        case .blank: return WindowGlyph(mode: .system, key: "square.dashed")
        case .notes: return WindowGlyph(mode: .system, key: "note.text")
        case .clock: return WindowGlyph(mode: .system, key: "clock")
        case .digitalClock: return WindowGlyph(mode: .system, key: "numbers.rectangle")
        case .themeMaker: return WindowGlyph(mode: .system, key: "paintpalette")
        case .stopwatch: return WindowGlyph(mode: .system, key: "stopwatch")
        }
    }
}

enum WindowGlyphMode: Codable {
    case system
    case custom
}

struct WindowGlyph: Codable {
    var mode: WindowGlyphMode
    var key: String
}
