//
//  CustomTextView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct CustomTextView: View {
    
    var fieldName: String
    @Binding var value: String
    var emptyErrorMessage: String
    var isButtonPress: Bool = false
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .topLeading) {
                  TextEditor(text: $value)
                      .padding(4)
                      .overlay(
                          RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.3)
                      )
                  
                  if value.isEmpty {
                      Text(fieldName)
                          .foregroundColor(.gray)
                          .padding(.horizontal, 8)
                          .padding(.vertical, 12)
//                          .padding(.top,20)
//                          .padding(.leading,20)
                  }
              }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            
            if value == "" && isButtonPress {
                HStack {
                    Text(emptyErrorMessage)
                        .font(.custom(FONT_REGULAR, size: 10))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                
            }
        }

    }
}

#Preview {
    CustomTextView(fieldName: "Subject", value: .constant(""), emptyErrorMessage: "")
}
