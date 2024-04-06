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
    var onCloseTapped: () -> Void
    var isCloseButtonVisible = true
    
    var body: some View {
        VStack {
            
            
            HStack {
                TextField(fieldName, text: self.$value,
                          prompt: Text(fieldName))
                .padding(15)
                .cornerRadius(20.0)
 
                
                
                if !value.isEmpty && isCloseButtonVisible {
                    Button {
                    onCloseTapped()
                    } label: {
                        Image("ic_search_close")
                            .resizable()
                            .frame(width: 20,height: 20)
                    }
                    .padding(.trailing)
                }

                
            }
            
            .overlay {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.gray, lineWidth: 0.3)
            }
            
        }
        
    }
}


#Preview {
    SearchView(fieldName: "Search Courses", value: .constant("mehdi"), onCloseTapped: {})
}
