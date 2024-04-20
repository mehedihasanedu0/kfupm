//
//  CustomDropDownView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct CustomDropDownView: View {
    
    @State var typeOfUserDropdownSelect: Bool = false
    var fieldName: String
    @Binding var value: String
    var emptyErrorMessage: String
    
    var body: some View {
        
        HStack {
            TextField(fieldName, text: self.$value,
                      prompt: Text(fieldName))
            .padding(15)
            .cornerRadius(20.0)

            

            Button {
                typeOfUserDropdownSelect.toggle()
            } label: {
                Image("ic_dropdown")
                    .resizable()
                    .frame(width: 22,height: 22)
                    .padding()
            }

        }
        .overlay {
            RoundedRectangle(cornerRadius: 7)
                .stroke(.gray, lineWidth: 0.3)
        }
        
        
        
    }
}

//#Preview {
//    CustomDropDownView(fieldName: "", value: .constant(""), emptyErrorMessage: "")
//}
