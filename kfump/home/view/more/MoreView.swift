//
//  MoreView.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct MoreView: View {
    
    var moreItems: [MoreItems] = MoreItems.sampleData // Replace with your data source
    
    var body: some View {
        ZStack {
            VStack {
                LazyVStack(spacing: 15) {
                    ForEach(moreItems) { item in
                        SingleItemView(isDotViewShow: (item.id == 6),
                                       isBottomDividerShow: item.id != 8,
                                       moreItems: item )
                    }
                }.padding(.bottom,20)
            }
        }
    }
}

#Preview {
    MoreView()
}
