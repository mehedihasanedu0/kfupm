////
////  Chat.swift
////  kfump
////
////  Created by Mehedi Hasan on 22/6/24.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct Chat: View, ChatDelegate {
//    func gotMessage(item: MessageResponse) {
//        print("got message on all message screen \(item.lastMessageAt)")
//        getInboxData.updateInboxMessage(message: item)
//        //        getInboxData.updateSeenMessage(id: "\(searchPeopleId)")
//        //getHomeData()
//        if !getInboxData.isAlreadyExist(message: item) {
//            badgeManager.badgeCount += 1
//        }
//    }
//    
//    @EnvironmentObject var badgeManager: BadgeManager
//    @StateObject var getInboxData = ChatService()
//    
//    @State var showChat = false
//    @State var showPeople = true
//    @State var showMessage = false
//    @State var searchPeople = ""
//    @State var searchPeopleId = 0
//    @State var searchPeopleMessage = ""
//    @State var chatPhoto = ""
//    @State var showAllChats = true
//    @State var messageText = ""
//    @State var chatPerson = "Sachin Tendulkar"
//    @State var chatDate = "March 27"
//    
//    @State var textFieldInput: String = ""
//    @State var predictableValues: Array<String> = ["Sachin", "Dravid", "Warne", "Gilchrist"]
//    @State var predictedValue: Array<String> = []
//    @State var value: String = ""
//    @State var hideChatSuggestions = true
//    @State private var navigateToChatInfo = false
//    let selfId = UserDefaults.standard.integer(forKey: "userId")
//    @State var isRTL = DataManager.shared.language.rawValue == "ar"
//    var language = DataManager.shared.language
//    
//    @State private var isTabBarHidden = false
//    @StateObject var homeService = HomescreenService()
//    
//    
//    var body: some View {
//        NavigationView {
//            ZStack{
//                VStack {
//                    VStack {
//                        NavigationLink(destination: MainChatView(remoteUserName: searchPeople, remoteUserId: searchPeopleId, message: messageText), isActive: $navigateToChatInfo){
//                            EmptyView()
//                        }
//                        
//                        HStack {
//                            
//                            Text("chatMain_chat".localized(language)).font(.custom("SST Arabic Roman", size: 24))
//                            Spacer()
//                            !getInboxData.isMessageEmpty ? AnyView(
//                                Image(systemName: "plus").padding(.horizontal, 11).padding(.vertical, 3).onTapGesture {
//                                    print("....")
//                                    showChat = true
//                                    showPeople = true
//                                    showMessage = false
//                                    searchPeople = ""
//                                    messageText = ""
//                                }
//                                    .sheet(isPresented: $showChat) {
//                                        HStack {
//                                            Text("chatIndividual_cancel".localized(language))
//                                                .foregroundColor(.blue)
//                                                .onTapGesture {
//                                                    showChat = false
//                                                    showPeople = true
//                                                    showMessage = false
//                                                    messageText = ""
//                                                }
//                                            Spacer()
//                                            Text("chatIndividual_newMessage".localized(language)).bold().font(.system(size: 21))
//                                            Text("")
//                                            Spacer()
//                                        }.padding()
//                                        
//                                        //                                if showPeople {
//                                        //                                    chatbody
//                                        //                                }
//                                        //
//                                        //                                if showMessage {
//                                        //                                    chatMessageView
//                                        //
//                                        //                                }
//                                        if showPeople {
//                                            chatbody
//                                                .presentationDetents([.fraction(0.75)])
//                                                .presentationDragIndicator(.visible)
//                                            
//                                        }
//                                        
//                                        if showMessage {
//                                            chatMessageView
//                                                .presentationDetents([.fraction(0.75)])
//                                                .presentationDragIndicator(.visible)
//                                            
//                                        }
//                                        
//                                    }
//                                
//                                    .overlay{
//                                        RoundedRectangle(cornerRadius: 17)
//                                            .stroke(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 1)
//                                    }) : AnyView(Text(""))
//                            
//                        }.onAppear(){
//                            getInboxData.getUserList(searchValue: searchPeople)
//                        }
//                        
//                        
//                        ScrollView(.vertical, showsIndicators: false) {
//                            VStack(alignment: .leading, spacing: 0) {
//                                ForEach(getInboxData.messageInboxItems, id: \.userId) { item in
//                                    //                                let user = item.user1?.id == selfId ? item.user2 : item.user1
//                                    //                                let userSeen = item.user1?.id == selfId ? item.user2_seen : item.user1_seen
//                                    
//                                    NavigationLink(destination: MainChatView(remoteUserName: item.displayName , remoteUserId: item.userId , message: "").onAppear{
//                                        self.isTabBarHidden = true
//                                    }) {
//                                        VStack {
//                                            HStack {
//                                                Image(systemName: "person.circle.fill")
//                                                    .font(.system(size: 40))
//                                                    .foregroundColor(.blue)
//                                                
//                                                VStack(alignment: .leading) {
//                                                    HStack{
//                                                        Text(item.displayName )
//                                                            .foregroundColor(.black)
//                                                            .font(.headline)
//                                                        Spacer()
//                                                        Text(item.lastMessageAt )
//                                                            .font(Font.custom("SST Arabic", size: 14))
//                                                            .multilineTextAlignment(.trailing)
//                                                            .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.22).opacity(0.4))
//                                                    }
//                                                    
//                                                    Text(item.lastMessage )
//                                                        .font(.body)
//                                                        .lineLimit(2)
//                                                        .foregroundColor(item.seen ? .primary : .secondary)
//                                                }
//                                                Spacer()
//                                                if !(item.seen ) {
//                                                    Image(systemName: "circle.fill")
//                                                        .foregroundColor(.red)
//                                                        .font(.system(size: 10))
//                                                }
//                                            }
//                                            .padding(.vertical, 4)
//                                            Divider().padding(.leading, 50)
//                                        }.padding(.vertical, 4)
//                                    }
//                                    .onDisappear{
//                                        //                                    self.isTabBarHidden = false
//                                    }
//                                }
//                            }
//                        }.onAppear {
//                            self.isTabBarHidden = false
//                            getInboxData.getInboxMessages()
//                            getHomeData()
//                            ChatClient.shared.connect()
//                            ChatClient.shared.delegate = self
//                            //                        ChatClient.shared.receiveMessage { message in
//                            //                            getInboxData.getInboxMessages()
//                            //                        }
//                        }
//                        .frame(alignment: .leading)
//                        .padding(.horizontal, 8)
//                        .padding(.vertical, 15)
//                        .background(.white)
//                    }
//                    .padding(.horizontal, 13)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                    
//                    
//                    getInboxData.isMessageEmpty ? AnyView(VStack {
//                        Image("newchat").frame(width: 160, height: 160)
//                        Text("chatEmpty_noMessage".localized(language)).font(.custom("SST Arabic Roman", size: 24))
//                            .frame(width: 350, height: 30, alignment: .center)
//                        
////                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.")
////                          .font(Font.custom("SST Arabic Roman", size: 14))
////                          .multilineTextAlignment(.center)
////                          .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.56))
////                          .frame(width: 350, height: 90)
//                          
//                        
//                        //  PredictingTextField(predictableValues: self.$predictableValues, predictedValues: self.$predictedValue, textFieldInput: self.$searchPeople)
//                        //                    .onTapGesture {
//                        //                    hideChatSuggestions = true
//                        //                }
//                        //                 ForEach(self.predictedValue, id: \.self){ value in
//                        //                    HStack {
//                        //                        hideChatSuggestions ? AnyView(Text(value)) : AnyView(Text(""))
//                        //                        Spacer()
//                        //                    }.onTapGesture {
//                        //                        searchPeople = value
//                        //                        hideChatSuggestions = false
//                        //                    }
//                        //                }
//                        
//                        Button(action: {
//                            print("new message tapped.")
//                            showChat = true
//                            showPeople = true
//                            showMessage = false
//                            searchPeople = ""
//                            messageText = ""
//                        }) {
//                            HStack(alignment: .center){
//                                Image(systemName: "plus")
//                                Text("chatEmpty_createNew".localized(language))
//                                    .foregroundColor(.black)
//                            }.frame(width: 301, height: 57)
//                        }
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 17)
//                                .stroke(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 1)
//                        }
//                        .sheet(isPresented: $showChat) {
//                            HStack {
//                                Text("chatIndividual_cancel".localized(language))
//                                    .foregroundColor(.blue)
//                                    .onTapGesture {
//                                        showChat = false
//                                        showPeople = true
//                                        showMessage = false
//                                        searchPeople = ""
//                                        messageText = ""
//                                    }
//                                Spacer()
//                                Text("chatIndividual_newMessage".localized(language)).bold().font(.system(size: 21))
//                                Text("")
//                                Spacer()
//                            }.padding()
//                            
//                            if showPeople {
//                                chatbody
//                                    .presentationDetents([.fraction(0.75)])
//                                    .presentationDragIndicator(.visible)
//                                
//                            }
//                            
//                            if showMessage {
//                                chatMessageView
//                                    .presentationDetents([.fraction(0.75)])
//                                    .presentationDragIndicator(.visible)
//                                
//                            }
//                            
//                        }
//                        
//                        Spacer().padding(.top, 250)
//                    }
//                    ) : AnyView( Text(""))
//                }
//                if getInboxData.isLoading  {
//                    CustomProgressView()
//                }
//                
//            }
//        }
//        
//        .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
//        
//      
//        
//    }
//    
////    private func getHomeData() {
////        homeService.getHomeData() { isSuccess in
////            if isSuccess {
////                // print("Chat Count \(homeService.homeData.data.chat)")
////                badgeManager.badgeCount = homeService.homeData.data.chat
////                
////            }
////        }
////    }
//}
//
//extension Chat {
//    var chatMessageView: some View {
//        VStack(alignment: .leading) {
//            HStack(spacing: -25) {
//                Text("To:")
//                    .foregroundColor(.gray)
//                    .padding(13)
//                    .cornerRadius(20.0)
//                
//                TextField("Search New Here", text: $searchPeople)
//                    .foregroundColor(.gray)
//                    .padding(13)
//                    .cornerRadius(20.0)
//            }
//            .overlay {
//                RoundedRectangle(cornerRadius: 7)
//                    .stroke(Color.gray, lineWidth: 1)
//            }
//            .padding([.top, .horizontal])
//            Spacer()
//            VStack {
//                HStack {
//                    TextField("chatIndividual_write".localized(language), text: self.$messageText)
//                        .foregroundColor(.gray)
//                        .padding(13)
//                        .cornerRadius(37.0)
//                    Image("sendmessage").onTapGesture {
//                        showChat = false
//                        showMessage = false
//                        showAllChats = true
//                        navigateToChatInfo = true
//                    }
//                    
//                }
//                .padding(.horizontal, 24)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 35)
//                        .stroke(.gray, lineWidth: 1)
//                        .padding(.horizontal, 13)
//                    
//                }
//                Text("")
//            }
//        }
//    }
//    
//}
//
//extension Chat {
//    //first
//    var chatbody: some View {
//        NavigationView {
//            ScrollView {
//                VStack {
//                    // Search View
//                    TextField("Search People", text: $searchPeople)
//                        .foregroundColor(.gray)
//                        .padding(13)
//                        .cornerRadius(20.0)
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 7)
//                                .stroke(Color.gray, lineWidth: 1)
//                        }
//                        .padding([.top, .horizontal])
//                        .onChange(of: searchPeople) { newValue in
//                            // Handle text field value changes
//                            getInboxData.getUserList(searchValue: searchPeople)
//                        }
//                    
//                    VStack(alignment: .leading){
//                        ForEach(getInboxData.userList, id: \.id) { item in
//                            HStack {
//                                HStack {
//                                    if let imageUrl = item.profilePicture {
//                                        WebImage(url: URL(string: imageUrl))
//                                            .placeholder(Image(systemName: "person.circle.fill"))
//                                            .resizable()
//                                            .indicator(.activity)
//                                            .transition(.fade(duration: 0.2))
//                                            .scaledToFill()
//                                            .frame(width: 48, height: 48)
//                                    } else {
//                                        Image("profile")
//                                            .frame(width: 48, height: 48)
//                                            .cornerRadius(25)
//                                            .padding(.horizontal, 9)
//                                    }
//                                    
//                                    Text(item.displayName)
//                                    
//                                }
//                                .padding()
//                                .onTapGesture {
//                                    
//                                    searchPeople = item.displayName
//                                    searchPeopleId = item.id
//                                    showPeople = false
//                                    showMessage = true
//                                }
//                            }
//                            Divider().padding(.leading, 50)
//                        }
//                    }
//                }.onAppear {
//                    getInboxData.getUserList(searchValue: searchPeople)
//                }
//            }
//        }
//    }
//}
//
//struct MessageDetailView: View {
//    let message: InboxItem
//    
//    var body: some View {
//        VStack {
//            Text(message.user1?.name ?? "No Name")
//                .font(.headline)
//            Text(message.last_message ?? "No message")
//                .font(.title)
//            Text(message.last_message_at ?? "time")
//                .font(.body)
//                .padding()
//        }
//        .navigationTitle(message.user1?.name ?? "No Name")
//    }
//}
