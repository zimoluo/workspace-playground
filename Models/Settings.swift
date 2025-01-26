import SwiftData
import SwiftUI

@Model
class Settings: ObservableObject {
    var theme: Theme
    var selectedSpaceId: UUID
    var windowsMenuButtonsPosition: WindowsMenuButtonPosition

    init(theme: Theme = BuiltinThemes.whim, windowsMenuButtonsPosition: WindowsMenuButtonPosition = .bottomTrailing) {
        self.theme = theme
        self.selectedSpaceId = UUID()
        self.windowsMenuButtonsPosition = windowsMenuButtonsPosition
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
