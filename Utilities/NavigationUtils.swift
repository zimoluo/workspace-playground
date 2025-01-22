import SwiftUI

struct Screen: Equatable {
    var type: ScreenType

    init(type: ScreenType = .empty) {
        self.type = type
    }
}

enum ScreenType {
    case empty
    case themeMaker
    case space
}
