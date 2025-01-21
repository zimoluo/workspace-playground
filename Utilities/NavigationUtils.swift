import SwiftUI

struct Screen: Equatable {
    var type: ScreenType
    var spaceId: UUID // reserved for the uuid of a workspace

    init(type: ScreenType = .empty, spaceId: UUID = UUID()) {
        self.type = type
        self.spaceId = spaceId
    }
}

enum ScreenType {
    case empty
    case themeMaker
    case space
}
