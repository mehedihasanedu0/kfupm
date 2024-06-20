//
//  NewMessageView.swift
//  kfump
//
//  Created by Mehedi Hasan on 16/6/24.
//

import SwiftUI

struct NewMessageView: View {
    
    @State var searchValue: String = ""
    @State var presentSheet :Bool = false
    @State var detentHeight: CGFloat = 0
    @State var showSearchView: Bool = false
    @State var isCloseButtonVisible: Bool = true
    
    @State private var filterItemIds: [Int] = []
    @StateObject var chatViewModel = ChatViewModel()
    
    
    
    var body: some View {
        
        ZStack {
            ScrollView {
                
                VStack {
                    Text("New message")
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity,alignment: .center)
                    
                    SearchView(fieldName: "Search People", value: $searchValue, onCloseTapped: {
                        print("searchValue =>  \(searchValue)")
                        searchValue = ""
                    },isCloseButtonVisible: isCloseButtonVisible)
                    .padding(.top)
                    .onTapGesture {
                        print("onTapGesture => ")
                        showSearchView = true
                        isCloseButtonVisible = true
                    }
                    .onChange(of: searchValue) { newValue in
                        if newValue != "" {
                            
                        }
                        
                    }
                    .onSubmit {
                        showSearchView = false
                        isCloseButtonVisible = true
                        self.hideKeyboard()
                    }
                    
                    ForEach(Array(filteredUserList.enumerated()), id: \.element.id) { index, user in
                        SingleNewMessageView(singleUser: user)
                        
                        Divider()
                            .background(hexToColor(hex: "#E5E5D9"))
                    }
                    .padding(.top)
                    
                }
            }
        }
        .onAppear {
            chatViewModel.getUserList()
        }
        .padding()
        
        
    }
    
    
    var filteredUserList: [AddUserModel] {
        if searchValue.isEmpty {
            return chatViewModel.userList
        } else {
            return chatViewModel.userList.filter { user in
                user.fullName?.lowercased().contains(searchValue.lowercased()) ?? false ||
                user.email?.lowercased().contains(searchValue.lowercased()) ?? false
            }
        }
    }
    
}

//#Preview {
//    NewMessageView()
//}
