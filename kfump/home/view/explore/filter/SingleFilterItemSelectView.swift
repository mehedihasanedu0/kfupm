//
//  SingleFilterItemSelectView.swift
//  kfump
//
//  Created by Mehedi Hasan on 4/4/24.
//

import SwiftUI

struct SingleFilterItemSelectView: View {
    
    @Binding var isItemSelect: Bool
    var itemName: String
    
    var onFilterItemSelect: () -> Void
    
    var body: some View {
        
        HStack {
            Image(isItemSelect ? "ic_check_box" : "ic_uncheck").resizable()
                .resizable()
                .frame(width: 20,height: 20)
                .onTapGesture {
                    onFilterItemSelect()
                }
            
            Text(itemName)
                .font(.custom(FONT_REGULAR, size: 14))
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
        }
        .padding(.vertical)
    }
}

#Preview {
    SingleFilterItemSelectView(isItemSelect: .constant(true), itemName: "Google", onFilterItemSelect: {})
}
