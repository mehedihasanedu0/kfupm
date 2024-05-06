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
            HStack {
                Text(email)
                    .font(.custom(FONT_LIGHT, size: 11))
                    .foregroundColor(.black)
                    .padding(5)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal,8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
        }
}

//#Preview {
//    SingleEmailView()
//}
