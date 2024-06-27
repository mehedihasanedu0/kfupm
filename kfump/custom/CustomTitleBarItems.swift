//
//  CustomTitleBarItems.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct CustomTitleBarItems: View {
    
    var isRTL = LocalizationSystem.shared.getLanguage() == "ar"
    @Environment(\.presentationMode) var presentationMode
    var title: String
    
    var body: some View {
        
        ZStack {
            
            HStack {
                Button(action: {
                    let isLogout = shared.object(forKey: IS_LOGIN_OUT_D) as? Bool ?? false
                    if !isLogout {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }) {
                    Image(isRTL ? "ic_back_ar" : "ic_back")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 25,height: 25)
                }
                
                Text(title)
                    .foregroundColor(.black)
                    .font(.custom(FONT_MEDIUM, size: 16))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        
        
    }
}
