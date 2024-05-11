//
//  SingleEmailView.swift
//  kfump
//
//  Created by Mehedi Hasan on 1/5/24.
//

import SwiftUI

struct SingleEmailView: View {
    let email: String
        var onDelete: () -> Void
        
        var body: some View {
            ZStack {
                Text(email)
                    .font(.custom(FONT_LIGHT, size: 11))
                    .foregroundColor(.black)
                    .padding(.horizontal, 5)
                    .padding(.vertical,8)
                    .padding(.trailing,20)
                    .multilineTextAlignment(.leading)
                
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal,8)
        }
}

//#Preview {
//    SingleEmailView()
//}
