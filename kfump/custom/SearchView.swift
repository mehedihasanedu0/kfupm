//
//  SearchView.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct SearchView: View {
    
    var fieldName: String
    @Binding var value: String
    var isButtonPress: Bool = false
    
    var body: some View {
        VStack {
            TextField(fieldName, text: self.$value,
                      prompt: Text(fieldName))
            .padding(20)
            .cornerRadius(20.0)
            .overlay {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.gray, lineWidth: 0.3)
            }
      
        }
        
        
        
    }
}


#Preview {
    SearchView(fieldName: "Search Courses", value: .constant(""))
}
