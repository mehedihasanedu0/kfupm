//
//  SingleItemView.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/3/24.
//

import SwiftUI

struct SingleItemView: View {
    
    var isDotViewShow: Bool = false
    var isBottomDividerShow: Bool = true
    var moreItems: MoreItems
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(moreItems.icone)
                        .resizable()
                        .frame(width: 50,height: 50)
                    
                    Text(moreItems.nameEn)
                        .padding(.leading,10)
                    
                    Spacer()
                    
                    if isDotViewShow {
                        Circle().frame(width: 10,height: 10)
                            .cornerRadius(5)
                            .foregroundColor(.blue)
                            .padding(.trailing,30)
                    }
                    
                }
                
                if isBottomDividerShow {
                    Divider()
                        .frame(maxWidth: .infinity)
                }

                
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,20)
        }
    }
}

//#Preview {
//    SingleItemView( moreItems: <#MoreItems#>)
//}
