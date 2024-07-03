//
//  NoDataFoundView.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/7/24.
//

import SwiftUI

struct NoDataFoundView: View {
    var body: some View {
        
        Text("No data found")
            .font(.custom(FONT_SEMIBOLD, size: 16))
            .foregroundColor(.gray)
            .padding(.top,400)
    }
}

#Preview {
    NoDataFoundView()
}
