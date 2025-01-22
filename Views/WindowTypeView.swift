import SwiftUI

struct WindowTypeView: View {
    let windowData: WindowData

    var body: some View {
        switch windowData.type {
        case .blank:
            Color.clear
        case .notes:
            ScrollView {
                VStack {
                    Text("Notes Window")
                    Text("Notes Window")
                    Text("Notes Window")
                    Text("Notes Window")
                    Text("Notes Window")
                    Text("Notes Window")
                    Text("Notes Window")
                    Text("Notes Window")
                }
            }
        }
    }
}
