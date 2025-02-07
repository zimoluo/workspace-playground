import SwiftData
import SwiftUI

@Model
class Settings: ObservableObject {
    var theme: Theme
    var selectedSpaceId: UUID
    var windowsMenuButtonsPosition: WindowsMenuButtonPosition
    var isWindowsMenuButtonExpanded: Bool
    var habits: [Habit]

    init(theme: Theme = BuiltinThemes.whim, windowsMenuButtonsPosition: WindowsMenuButtonPosition = .bottomTrailing, isWindowsMenuButtonExpanded: Bool = false, habits: [Habit] = []) {
        self.theme = theme
        self.selectedSpaceId = UUID()
        self.windowsMenuButtonsPosition = windowsMenuButtonsPosition
        self.isWindowsMenuButtonExpanded = isWindowsMenuButtonExpanded
        self.habits = habits
    }
}

enum WindowsMenuDirection: String, Codable {
    case top, bottom, leading, trailing
}

enum WindowsMenuButtonPosition: String, Codable {
    case bottomTrailing, bottomLeading, leading, trailing, bottomCenterTrailing, bottomCenterLeading

    var menuDirection: WindowsMenuDirection {
        switch self {
        case .bottomTrailing: return .top
        case .bottomLeading: return .top
        case .leading: return .bottom
        case .trailing: return .bottom
        case .bottomCenterLeading: return .trailing
        case .bottomCenterTrailing: return .leading
        }
    }
}

struct Habit: Codable {
    var id: UUID
    var name: String
    var dateCreated: Date
    var dateModified: Date

    var timesKept: [Date]
    var timesDisliked: [Date]
}
