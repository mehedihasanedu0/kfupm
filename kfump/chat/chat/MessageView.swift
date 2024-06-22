//
//  MessageView.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/6/24.
//

import SwiftUI

struct MessageView : View {
    
    let currentMessage : ChatMessage!
   // var currentMessage: Message
    @AppStorage(Keys.USER_ID.rawValue) var myId: Int?
//    @State private var myId = UserDefaults.standard.integer(forKey: "userId")
    var body: some View {
        HStack(alignment: .bottom) {
            if currentMessage.sender != myId {
                HStack {
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40, alignment: .center)
//                        .cornerRadius(20)
                    //Text(currentMessage.text ?? "")
                }
//                Spacer()
                
            } else {
                Spacer()
            }
            MessageCell(contentMessage: currentMessage.text ?? "", time: currentMessage.createdAt ?? "",
                        isCurrentUser: currentMessage.sender == myId )
            
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(4)
    }
}


//#Preview {
//    MessageView(currentMessage: Message(content: "This is a single message cell with avatar. If user is current user, we won't display the avatar.", isCurrentUser: false))
//}
