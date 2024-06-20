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
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    if chatViewModel.rooList.count == 0 {
                        emptyInboxView
                    } else {
                        ForEach(Array(chatViewModel.rooList.enumerated()), id: \.element.id) { index, user in
                            SingleInboxView(chatItem: user)
                            
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
        .navigationBarItems(leading: CustomTitleBarItems(title: "Inbox"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .navigationDestination(isPresented: $isNavigateToNewMessageView, destination: { NewMessageView().navigationBarBackButtonHidden(true) })
        
        
    }
    
    var emptyInboxView : some View {
        VStack {
            
            Text("You don’t have any message!")
                .font(.custom(FONT_BOLD, size: 16))
                .padding(.bottom,10)
                .padding(.top,150)
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.")
                .font(.custom(FONT_REGULAR, size: 16))
                .foregroundColor(hexToColor(hex: "#7C7C7C"))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity,alignment: .center)
            
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
}

//#Preview {
//    EmptyInboxView()
//}
