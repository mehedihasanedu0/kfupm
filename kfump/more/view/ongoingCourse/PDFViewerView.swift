//
//  PDFViewerView.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/5/24.
//

import SwiftUI

struct PDFViewerView: View {
    
    let url: String!
    var body: some View {
        
        ZStack {
            VStack {
                PDFViewWrapper(url: URL(string: url)!)
                    .edgesIgnoringSafeArea(.all)
                
                
                Divider()
                
                saveButtonView
                    .padding(.leading,25)
                    .padding(.bottom,30)
            }
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "User experience careers"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
    }
    
    var saveButtonView: some View {
        
        HStack {
            
            Button(action: {
                
                
            }) {
                HStack {
                    
                    Text("Download PDF")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(.white)
     
                }
                
                
                
            }
            
            .frame(width: 156, height: 45)
            .background(hexToColor(hex: "#007D40"))
            .cornerRadius(22)
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
            }
            
            Spacer()
            
            HStack {
                Text("Next")
                    .font(.custom(FONT_SEMIBOLD, size: 16))
                    .foregroundColor(hexToColor(hex: "#007D40"))
                
                Image(isRTL ? "ic_next_ar"  : "ic_next")
                    .resizable()
                    .frame(width: 20,height: 20)
            }
            .padding(.trailing,25)
        }
        .padding(.top)
    }
}

//#Preview {
//    
//    PDFViewerView(url: URL(string: "https://kfu-admin.ewnbd.com/media/uploads/title_5MgGjYQ.pdf")!)
//}
