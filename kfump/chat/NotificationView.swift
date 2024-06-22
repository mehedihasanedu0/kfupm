//
//  NotificationView.swift
//  kfump
//
//  Created by Mehedi Hasan on 15/6/24.
//

import SwiftUI

struct NotificationView: View {
    
    @StateObject var chatViewModel = ChatViewModel()
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(Array(chatViewModel.notificationList.enumerated()), id: \.element.id) { index, user in
                        SingleNotificationView(singleNotification: user)
                        
                        Divider()
                            .background(hexToColor(hex: "#E5E5D9"))
                    }
                    .padding(.top)
                }
            }
            .scrollIndicators(.never)
        }
        .onAppear {
            chatViewModel.getNotificationList()
        }
        .padding(.horizontal)
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Notification"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
    }
}

#Preview {
    NotificationView()
}
