//
//  NoDataFoundView.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/7/24.
//

import SwiftUI

struct NoDataFoundView: View {
    
    let message: String!
    var body: some View {
        
        Text(message)
            .font(.custom(FONT_SEMIBOLD, size: 16))
            .foregroundColor(.gray)
            .padding(.top,400)
    }
}

#Preview {
    NoDataFoundView(message: "")
}
