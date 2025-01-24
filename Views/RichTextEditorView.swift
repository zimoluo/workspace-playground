import SwiftUI

struct RichTextEditorView: View {
    @State private var text = AttributedString()
    
    var body: some View {
        TextEditor(text: Binding(
            get: { text },
            set: { text = $0 }
        ))
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollDisabled(false)
        .textSelection(.enabled)
        .contextMenu {
            Button("Bold") {
                toggleBold()
            }
            Button("Italic") {
                toggleItalic()
            }
        }
    }
    
    private func toggleBold() {
        var mutableText = text
        mutableText.setBoldState(.some(true))
        text = mutableText
    }
    
    private func toggleItalic() {
        var mutableText = text
        mutableText.setItalicState(.some(true))
        text = mutableText
    }
}