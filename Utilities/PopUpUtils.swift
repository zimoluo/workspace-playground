import SwiftUI

enum PopUpType {
    case empty
    case themeMakerGuide
    case tips_menu
    case tips_theme
    case tips_technical
}

class PopUp: ObservableObject {
    @Published var type: PopUpType

    init(type: PopUpType = .empty) {
        self.type = type
    }
}
