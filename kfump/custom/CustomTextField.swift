//
//  CustomTextView.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/3/24.
//

import SwiftUI

struct CustomTextField: View {
    
    var fieldName: String
    @Binding var value: String
    var emptyErrorMessage: String
    var isButtonPress: Bool = false
    
    var body: some View {
        VStack {
            TextField(fieldName, text: self.$value,
                      prompt: Text(fieldName))
            .padding(15)
            .cornerRadius(20.0)
            .overlay {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.gray, lineWidth: 0.3)
            }
            
            if value == "" && isButtonPress {
                HStack {
                    Text(emptyErrorMessage)
                        .font(.custom(FONT_NAME, size: 10))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                
            }
        }
        
        
        
    }
}

//#Preview {
//    CustomTextField(fieldName: "Email", emptyErrorMessage: "", value: .constant(""))
//}
