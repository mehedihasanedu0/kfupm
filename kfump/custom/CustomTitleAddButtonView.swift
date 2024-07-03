//
//  CustomTitleAddButtonView.swift
//  kfump
//
//  Created by Mehedi Hasan on 30/6/24.
//

import SwiftUI

struct CustomTitleAddButtonView: View {
    var onAddButtonTapped: () -> Void
    var body: some View {
        Button {
            onAddButtonTapped()
        } label: {
            
            VStack {
                Image("ic_add_icon")
                    .resizable()
                    .padding(5)
            }
            .frame(width: 32,height: 32)
            .background(hexToColor(hex: "#007D40"))
            .cornerRadius(16)
            
        }
    
    }
}

#Preview {
    CustomTitleAddButtonView(onAddButtonTapped: {})
}
