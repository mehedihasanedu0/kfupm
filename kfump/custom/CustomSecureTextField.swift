//
//  CustomSecureTextField.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/3/24.
//

import SwiftUI

struct CustomSecureTextField: View {
    
    @State var showPassword: Bool = false
    var fieldName: String
    @Binding var password: String
    var emptyErrorMessage: String
    var isButtonPress: Bool = false
    
    var body: some View {
        VStack {
            
            HStack {
                Group {
                    if showPassword {
                        TextField(fieldName,
                                  text: $password,
                                  prompt: Text(fieldName))
                        .padding(13)
                    } else {
                        SecureField(fieldName,
                                    text: $password,
                                    prompt: Text(fieldName)).padding(13)
                    }
                }
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(13)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.gray, lineWidth: 0.3)
            }
            
            if password == "" && isButtonPress {
                HStack {
                    Text(emptyErrorMessage)
                        .font(.custom(FONT_MEDIUM, size: 10))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                
            }
        }
        
    }
}

#Preview {
    CustomSecureTextField(fieldName: "Password", password: .constant(""), emptyErrorMessage: "")
}
