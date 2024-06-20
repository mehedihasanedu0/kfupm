//
//  SingleNewMessageView.swift
//  kfump
//
//  Created by Mehedi Hasan on 16/6/24.
//

import SwiftUI

struct SingleNewMessageView: View {
    
    let singleUser : AddUserModel!
    
    var body: some View {
        HStack {
            
            WebImageView(imageUrl: singleUser.image ?? "")
                .frame(width: 50,height: 50)
                .cornerRadius(25)
            
                
            Text(singleUser.fullName ?? "")
                .font(.custom(FONT_REGULAR, size: 16))
                .foregroundColor(hexToColor(hex: "#7C7C7C"))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,alignment: .leading)
            
        }
    }
}
//
//#Preview {
//    SingleNewMessageView()
//}
