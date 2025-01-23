import SwiftData
import SwiftUI

@Model
class Settings: ObservableObject {
    var theme: Theme
    var selectedSpaceId: UUID

    init(theme: Theme = BuiltinThemes.whim) {
        self.theme = theme
        self.selectedSpaceId = UUID()
    }
}
