import SwiftData
import SwiftUI

struct Window {
    var id: UUID

    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var data: WindowData

    init(
        x: CGFloat = 0,
        y: CGFloat = 0,
        width: CGFloat = 100,
        height: CGFloat = 100,
        data: WindowData = .init()
    ) {
        self.id = UUID()
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.data = data
    }
}

struct WindowData {
    var type: WindowType
    var saveData: [String: String]
    var minHeight: CGFloat
    var minWidth: CGFloat
    var maxHeight: CGFloat
    var maxWidth: CGFloat
    var layer: Int

    init(
        type: WindowType = .blank,
        saveData: [String: String] = [:],
        minHeight: CGFloat = 0,
        minWidth: CGFloat = 0,
        maxHeight: CGFloat = .infinity,
        maxWidth: CGFloat = .infinity,
        layer: Int = 0
    ) {
        self.type = type
        self.saveData = saveData
        self.minHeight = minHeight
        self.minWidth = minWidth
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.layer = layer
    }
}

enum WindowType {
    case blank
    case notes
}
