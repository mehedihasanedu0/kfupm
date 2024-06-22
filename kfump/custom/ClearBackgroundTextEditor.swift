//
//  ClearBackgroundTextEditor.swift
//  kfump
//
//  Created by Mehedi Hasan on 23/6/24.
//

import SwiftUI

struct ClearBackgroundTextEditor: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear // Make UITextView background clear
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ClearBackgroundTextEditor

        init(_ parent: ClearBackgroundTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
