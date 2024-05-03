//
//  CustomOtpTextField.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/5/24.
//

import Foundation
import SwiftUI

struct CustomOtpTextField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Detects if backspace/delete is pressed when the text field is empty
            if range.length == 1 && string.isEmpty && text.isEmpty {
                print("Delete key pressed while textField is empty")
            }
            return true
        }
    }
}
