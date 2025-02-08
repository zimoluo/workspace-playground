import SwiftUI

enum PopUpType: String, Codable {
    case empty
    case themeMakerGuide
    case tips_menu
    case tips_theme
    case tips_technical
    case tips_window
    case welcome
}

class PopUp: ObservableObject {
    @Published var type: PopUpType

    init(type: PopUpType = .empty) {
        self.type = type
    }
}
