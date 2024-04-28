//
//  TagView.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/4/24.
//

import SwiftUI

struct TagView: View {
    let email: String
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text(email)
                .foregroundColor(.black)
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}
//
//#Preview {
//    TagView()
//}
