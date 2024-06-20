//
//  SingleInboxView.swift
//  kfump
//
//  Created by Mehedi Hasan on 16/6/24.
//

import SwiftUI

struct SingleInboxView: View {
    
    var chatItem : ChatItem!
    
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    
    var body: some View {
        
        VStack {
            
            HStack {
                VStack {
                    
                    WebImageView(imageUrl: getImage)
                        .frame(width: 60,height: 60)
                        .cornerRadius(30)
                    
                    Spacer()
                }
                
                
                VStack {
                    
                    HStack {
                        Text(getFullName)
                            .font(.custom(FONT_MEDIUM, size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("March 27")
                            .font(.custom(FONT_MEDIUM, size: 16))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                    }
                    .padding(.bottom,2)
                    
                    
                    Text(chatItem.lastMessage ?? "")
                        .font(.custom(FONT_REGULAR, size: 16))
                        .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding(.leading,3)
            }
            
        }
        .frame(height: 100)
    }
    
    var getFullName : String {
        if userUUID == chatItem.sender.uuid {
            return chatItem.receiver.fullName ?? ""
        } else {
            return chatItem.sender.fullName ?? ""
        }
    }    
    
    var getImage : String {
        if userUUID == chatItem.sender.uuid {
            return chatItem.receiver.image ?? ""
        } else {
            return chatItem.sender.image ?? ""
        }
    }
}

//#Preview {
//    SingleInboxView()
//}
