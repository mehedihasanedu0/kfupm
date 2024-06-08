//
//  TermsAndConditionView.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/6/24.
//

import SwiftUI

struct TermsAndConditionView: View {
    var body: some View {
        ZStack {
            
        }                .padding(.horizontal)
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .navigationBarItems(leading: CustomTitleBarItems(title: "Terms And Condition"))
            .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
    }
}

#Preview {
    TermsAndConditionView()
}
