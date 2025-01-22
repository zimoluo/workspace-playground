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
        self.state = state
        self.data = WindowData.applyDefaults(baseData: data)
    }
}

// WindowState stores the dimension and position of the window. Due to its changeable nature, it's managed by windows themselves, but it's also stored in model context in order to persist. Windows will choose specific occasions, like right after finishing dragging, to sync its version of WindowState with the model context. This means individual windows only need its own copy of state and its UUID which is used to link itself to the model context.
// In short, WindowState is kept and managed by windows themselves and only synced to the model context at select occasions.
struct WindowState: Codable {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 100
    var height: CGFloat = 100
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
    var layer: Int
    var order: Int

    init(
        type: WindowType = .blank,
        saveData: [String: String] = [:],
        minHeight: CGFloat = 0,
        minWidth: CGFloat = 0,
        maxHeight: CGFloat = 1_000_000_000,
        maxWidth: CGFloat = 1_000_000_000,
        layer: Int = 0,
        order: Int = 0
    ) {
        self.type = type
        self.saveData = saveData
        self.minHeight = minHeight
        self.minWidth = minWidth
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.layer = layer
        self.order = order
    }

    static func applyDefaults(baseData: WindowData) -> WindowData {
        var updatedData = baseData

        switch updatedData.type {
        case .notes:
            updatedData.maxHeight = 500
            updatedData.maxWidth = 800
            updatedData.minHeight = 200
            updatedData.minWidth = 300
        case .blank:
            break
        }

        return updatedData
    }
}

enum WindowType: String, Codable {
    case blank
    case notes
}
