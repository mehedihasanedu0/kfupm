//
//  CustomSuccessView.swift
//  kfump
//
//  Created by Mehedi Hasan on 4/6/24.
//

import SwiftUI

struct CustomSuccessView: View {
    
    var title: String
    var message: String
    var onCancel: () -> Void
    
    var body: some View {
        VStack {
            
            HStack {
                
                
                Spacer()
                
                Image("ic_logout_close")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .onTapGesture {
                        onCancel()
                    }
                
            }
            .padding(.horizontal)
            
            
            Image("ic_success_alert")
                .resizable()
                .frame(width: 130,height: 105)
                .onTapGesture {
                    onCancel()
                }
            
            Text(title)
                .font(.custom(FONT_MEDIUM, size: 20))
            
            Text(message)
                .font(.custom(FONT_LIGHT, size: 15))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top,1)
                .padding(.bottom,10)
                .frame(maxWidth: .infinity)
            
        }
        .frame(width: 350, height: 290)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}


//#Preview {
//    CustomSuccessView(title: "Request Sent Successfully", message: "Your course has been created successfully. Please wait for admin approval. After that, your course will be withdraw.", onCancel:  {})
//}
