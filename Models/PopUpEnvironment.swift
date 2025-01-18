
import SwiftUI

struct PopUpKey: EnvironmentKey {
    static let defaultValue: PopUpType = .empty
}

extension EnvironmentValues {
    var popUp: PopUpType {
        get { self[PopUpKey.self] }
        set { self[PopUpKey.self] = newValue }
    }
}
