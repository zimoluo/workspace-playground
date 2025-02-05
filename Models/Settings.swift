import SwiftData
import SwiftUI

@Model
class Settings: ObservableObject {
    var theme: Theme
    var selectedSpaceId: UUID
    var windowsMenuButtonsPosition: WindowsMenuButtonPosition
    var isWindowsMenuButtonExpanded: Bool
    var habits: [Habit]
    var moods: [Mood]

    init(theme: Theme = BuiltinThemes.whim, windowsMenuButtonsPosition: WindowsMenuButtonPosition = .bottomTrailing, isWindowsMenuButtonExpanded: Bool = false, habits: [Habit] = [], moods: [Mood] = []) {
        self.theme = theme
        self.selectedSpaceId = UUID()
        self.windowsMenuButtonsPosition = windowsMenuButtonsPosition
        self.isWindowsMenuButtonExpanded = isWindowsMenuButtonExpanded
        self.habits = habits
        self.moods = moods
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

struct MoodGradient: Codable {
    var points: [SIMD2<Float>]
    var colors: [RGBAColor]

    func toGradient() -> MeshGradient {
        let fixedPoints = points.prefix(9) + Array(repeating: SIMD2<Float>(0.5, 0.5), count: max(0, 9 - points.count))
        let fixedColors = colors.prefix(9) + Array(repeating: RGBAColor(.white), count: max(0, 9 - colors.count))

        return MeshGradient(
            width: 3,
            height: 3,
            points: Array(fixedPoints),
            colors: fixedColors.map { $0.color }
        )
    }
}

struct Mood: Codable {
    var id: UUID
    var dateCreated: Date
    var dateModified: Date

    var level: CGFloat
    var gradient: MoodGradient
}
