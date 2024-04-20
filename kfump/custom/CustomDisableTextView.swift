//
//  CustomDisableTextView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct CustomDisableTextView: View {
    var fieldName: String
    @Binding var value: String
    var emptyErrorMessage: String
    var isButtonPress: Bool = false
    
    var body: some View {
        VStack {
            TextField(fieldName, text: self.$value,
                      prompt: Text(fieldName))
            .font(.custom(FONT_MEDIUM, size: 15))
            .padding(15)
            .cornerRadius(20.0)
            .foregroundColor(hexToColor(hex: "#B8B8B8"))


        }
        .background(hexToColor(hex: "#E5E5D9"))
        .cornerRadius(10)
        
        
        
    }
}

#Preview {
    CustomDisableTextView(fieldName: "johndoe787@gmail.com", value: .constant(""), emptyErrorMessage: "")
}
