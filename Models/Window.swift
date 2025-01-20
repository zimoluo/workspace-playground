import SwiftData
import SwiftUI

struct Window {
    var id: UUID

    var state: WindowState
    var data: WindowData

    init(
        state: WindowState = .init(),
        data: WindowData = .init(),
        order: Int = 0
    ) {
        self.id = UUID()
        self.state = state
        self.data = data
    }
}

// WindowState stores the dimension and position of the window. Due to its changeable nature, it's managed by windows themselves, but it's also stored in model context in order to persist. Windows will choose specific occasions, like right after finishing dragging, to sync its version of WindowState with the model context. This means individual windows only need its own copy of state and its UUID which is used to link itself to the model context.
struct WindowState {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 100
    var height: CGFloat = 100
}

// WindowData is directly tied to the model context, meaning that individual windows won't keep their own version of the window data, and every change happens directly at the app data level. It's still mutable, but much less needed compared to WindowState, so the performance impact is minimal.
struct WindowData {
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
        maxHeight: CGFloat = .infinity,
        maxWidth: CGFloat = .infinity,
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
}

enum WindowType {
    case blank
    case notes

    func presetData() -> WindowData {
        switch self {
        case .blank:
            return WindowData(
                type: .blank,
                saveData: [:],
                minHeight: 0,
                minWidth: 0,
                maxHeight: .infinity,
                maxWidth: .infinity,
                layer: 0
            )
        case .notes:
            return WindowData(
                type: .notes,
                saveData: [:],
                minHeight: 200,
                minWidth: 300,
                maxHeight: 300,
                maxWidth: 500,
                layer: 1
            )
        }
    }
}
