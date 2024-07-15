//
//  EmptyInboxView.swift
//  kfump
//
//  Created by Mehedi Hasan on 15/6/24.
//

import SwiftUI

struct EmptyInboxView: View {
    
    @StateObject var chatViewModel = ChatViewModel()
    
    @State var isNavigateToNewMessageView :Bool = false
    @State var isNavigateToChat :Bool = false
    
    @State var userName : String = ""
    @State var userId : Int = 0
    @State var message : String = ""
    
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    if chatViewModel.rooList.count == 0 {
                        emptyInboxView
                    } else {
                        ForEach(Array(chatViewModel.rooList.enumerated()), id: \.element.id) { index, user in
                            SingleInboxView(chatItem: user)
                                .onTapGesture {
                                    userName = getFullName(user: chatViewModel.rooList[index])
                                    userId = getUserId(user: chatViewModel.rooList[index])
                                    isNavigateToChat = true
                                }
                            
                            Divider()
                                .background(hexToColor(hex: "#E5E5D9"))
                        }
                        .padding(.top)
                    }
                }
            }
        }
        .onAppear {
            chatViewModel.getRoomList()
        }
        .padding(.horizontal)
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Inbox"),trailing: CustomTitleAddButtonView( onAddButtonTapped: {
            print("Add Button Tap")
            isNavigateToNewMessageView = true

        }))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .navigationDestination(isPresented: $isNavigateToNewMessageView, destination: { NewMessageView().navigationBarBackButtonHidden(true) })
        .navigationDestination(isPresented: $isNavigateToChat, destination: { MainChatView(remoteUserName: userName, remoteUserId: userId, message: "").navigationBarBackButtonHidden(true) })
        
        
    }
    
    var emptyInboxView : some View {
        VStack {
           
            Text(LocalizationSystem.shared.localizedStringForKey(key: REPORT_AN_ISSUE_EMPTY_MESSAGE_KEY, comment: ""))
                .font(.custom(FONT_BOLD, size: 16))
                .padding(.bottom,10)
                .padding(.top,150)
            
//            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.")
//                .font(.custom(FONT_REGULAR, size: 16))
//                .foregroundColor(hexToColor(hex: "#7C7C7C"))
//                .multilineTextAlignment(.center)
//                .frame(maxWidth: .infinity,alignment: .center)
            
            Button(action: {
            
                print("Login Button Press")
                isNavigateToNewMessageView = true
                
            }) {
                Text("Create New Message")
                    .padding(.vertical,10)
                    .font(.custom(FONT_BOLD, size: 16))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .foregroundColor(.white)
                
            }
            
            .background(hexToColor(hex: "#007D40"))
            .frame(height: 56)
            .cornerRadius(10.0)
            .padding(.top,20)
        }
    }
    
    func getFullName(user: ChatItem) -> String {
        if userUUID == user.sender?.uuid {
            return user.receiver?.fullName ?? ""
        } else {
            return user.sender?.fullName ?? ""
        }
    }   
    
    func getUserId(user: ChatItem) -> Int {
        if userUUID == user.sender?.uuid {
            return user.receiver?.id ?? 0
        } else {
            return user.sender?.id ?? 0
        }
    }
}

//#Preview {
//    EmptyInboxView()
//}
