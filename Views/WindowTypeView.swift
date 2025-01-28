import SwiftUI

struct WindowTypeView: View {
    let windowData: WindowData

    var body: some View {
        switch windowData.type {
        case .blank:
            Color.clear
        case .notes:
            RichTextEditorView()
        case .clock:
            ClockWidget()
        case .digitalClock:
            DigitalClock()
        case .themeMaker:
            ThemeMaker()
                .padding(12)
                .frame(maxWidth: .infinity)
        case .stopwatch:
            StopwatchView()
        }
    }
}
