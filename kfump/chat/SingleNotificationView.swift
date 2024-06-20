//
//  SingleNotificationView.swift
//  kfump
//
//  Created by Mehedi Hasan on 15/6/24.
//

import SwiftUI

struct SingleNotificationView: View {
    
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image("ic_notification_unseen")
                    .resizable()
                    .frame(width: 50,height: 50)
                
                VStack {
                    
                    HStack {
                        Text("Payment Successful")
                            .font(.custom(FONT_MEDIUM, size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Divider()
                            .frame(width: 10,height: 10)
                            .background(hexToColor(hex: "#007D40"))
                            .cornerRadius(5.0)
                    }
                    
                    
                    Text("You have successfully enrolled the course")
                        .font(.custom(FONT_REGULAR, size: 16))
                        .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding(.leading,10)
            }
            
        }
        
       
    }
}

#Preview {
    SingleNotificationView()
}
