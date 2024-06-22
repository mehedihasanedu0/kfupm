//
//  MessageCell.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/6/24.
//

import Foundation
import SwiftUI

struct MessageCell: View {
    var contentMessage: String
    var time: String
    var isCurrentUser: Bool
    
    var body: some View {
        
//        VStack {
//            Text(contentMessage)
//                .padding(10)
//                .foregroundColor(isCurrentUser ? Color.white : Color.black)
//                .background(isCurrentUser ? Color.blue : Color(UIColor.systemGray6 ))
//               // .cornerRadius(10)
//                .clipShape(
//                    .rect(
//                        topLeadingRadius: 10,
//                        bottomLeadingRadius: isCurrentUser ? 10 : 0,
//                        bottomTrailingRadius: isCurrentUser ? 0 : 10,
//                        topTrailingRadius: 10
//                    )
//                )
////            Text(Utils.chatTimeformatDateString(time) ?? "")
////                .foregroundColor(Color.gray)
////                .font(.custom("sst-arabic-bold", size: 10))
//        }
        
        
        
        VStack {
            Text(contentMessage)
                .padding(10)
                .foregroundColor(Color.black)
                .padding(.bottom,6)
            
            Text("          ")
                .foregroundColor(Color.black)
                .font(.custom("sst-arabic-bold", size: 8))
                .padding(.bottom, 8)
                .padding(.horizontal, 8)
                .frame(width: 80, height: 1)
        }
        .overlay(
            Text(Utils.chatTimeformatDateString(time) ?? "")
                .foregroundColor(Color.black)
                .font(.custom("sst-arabic-bold", size: 8))
                .padding(.bottom, 8)
                .padding(.horizontal, 8)
                .frame(minWidth: 100, maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading),
            alignment: isCurrentUser ? .bottomTrailing : .bottomLeading
        )
        .background(isCurrentUser ? hexToColor(hex: "#E8F0EA") : hexToColor(hex: "#F2F2F2"))
        .clipShape(
            .rect(
                topLeadingRadius: 15,
                bottomLeadingRadius: isCurrentUser ? 15 : 0,
                bottomTrailingRadius: isCurrentUser ? 0 : 15,
                topTrailingRadius: 15
            )
        )
        .padding(.horizontal, 8)
        
        
    }
}
