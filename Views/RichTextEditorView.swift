import SwiftUI

struct RichTextEditor: UIViewRepresentable {
    @Binding var text: NSAttributedString
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textColor = UIColor(themeColor(from: theme, for: .secondary, in: colorScheme))
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 24)
        
        textView.allowsEditingTextAttributes = true
        textView.isUserInteractionEnabled = true
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextEditor
        
        init(_ parent: RichTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.attributedText
        }
    }
}

struct RichTextEditorView: View {
    @State private var text: NSAttributedString = .init(string: "Start typing here...")
    
    var body: some View {
        RichTextEditor(text: $text)
            .padding(16)
            .background(.clear)
            .cornerRadius(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

#Preview {
    RichTextEditorView()
}
