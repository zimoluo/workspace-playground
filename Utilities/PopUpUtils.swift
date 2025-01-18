import SwiftUI

enum PopUpType {
    case empty
    case themeMakerGuide
}

class PopUp: ObservableObject {
    @Published var type: PopUpType

    init(type: PopUpType = .empty) {
        self.type = type
    }
}
