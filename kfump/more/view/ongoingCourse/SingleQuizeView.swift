//
//  SingleQuizeView.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/5/24.
//

import SwiftUI

struct SingleQuizeView: View {
    
    var questionTitle : String!
    @Binding var ans: String
    
    var body: some View {
        VStack {
            HStack {
                Divider()
                    .frame(width: 4,height: 4)
                    .background(.gray)
                    .cornerRadius(2)
                
                Text(questionTitle)
                    .font(.custom(FONT_MEDIUM, size: 14))
                    .foregroundColor(.black)
                
                Spacer()
                
            }
            
            CustomTextField(fieldName: "Write your answer here", value: $ans, emptyErrorMessage: "This field can't be empty")
        }
    }
}

//#Preview {
//    SingleQuizeView(questionTitle: <#T##String!#>, ans: )
//}
