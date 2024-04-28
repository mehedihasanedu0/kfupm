//
//  EmailChipView.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/4/24.
//

import SwiftUI

struct EmailChipView: View {
    var email: String
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text(email)
                .foregroundColor(.white)
                .padding(.leading, 10)
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
            }
            .padding(.trailing, 10)
        }
        .padding(.vertical, 5)
        .background(Color.blue)
        .cornerRadius(15)
    }
}

//#Preview {
//    EmailChipView()
//}
