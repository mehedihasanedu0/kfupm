import Combine
import SwiftUI

struct MainChatView: View, ChatDelegate {
    
    func gotMessage(item: MessageResponse) {
        //chatViewModel.isLoadMore = false
        var messageModel = ChatMessage(id: item.receiver, createdAt: item.createdAt, text: item.text, sender: item.sender)
        chatService.messages.append(messageModel)
        //        if item.receiver == myId || item.sender == myId {
        //            if item.receiver == remoteUserId {
        //                messageModel.sender = myId
        //            } else {
        //                messageModel.sender = remoteUserId
        //                //chatViewModel.updateSeenMessage(id: "\(remoteUserId)")
        //            }
        //            //chatViewModel.addNewMessage(message: messageModel)
        //        }
    }
    
    var remoteUserName: String
    var remoteUserId: Int
    var message: String
    
    @StateObject var chatService = ChatViewModel()
    
    @State var newMessage: String = ""
    @AppStorage(Keys.USER_ID.rawValue) var myId: Int?
    //    @State private var myId = UserDefaults.standard.integer(forKey: "userId")
    @State private var isLoadMore = false
    @State var isNewMessage = true
    
    @State private var lastElement: ChatMessage?
    
    @Environment(\.presentationMode) var presentationMode
    
    //    @StateObject private var keyboardObserver = KeyboardObserver()
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    
    
    
    var body: some View {
        ZStack{
            VStack {
                
                
                ScrollViewReader { proxy in
                    List(chatService.messages,  id: \.id) { messagess in
                        MessageView(currentMessage: messagess)
                            .listRowSeparator(.hidden)
                            .listStyle(PlainListStyle())
                            .id(messagess)
                            .onAppear {
                                lastElement = messagess
                                
                                //                                if messagess == chatService.messages[0] {
                                //                                    chatService.loadMore(userId: "\(remoteUserId)")
                                //                                }
                                
                            }
                            .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                        // .frame(height: 40)
                        
                    }
                    .onChange(of: chatService.messages) { _ in
                        proxy.scrollTo(chatService.messages.last?.id, anchor: .bottom)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.white)
                    .padding(.horizontal, -20)
                    .padding(EdgeInsets(top: -20, leading: 0, bottom: -10, trailing: 0))
                    
                    .onReceive(Just(chatService.messages)) { _ in
                        
                        //                        if !chatService.isLoadMore {
                        //                            withAnimation {
                        //                                proxy.scrollTo(chatService.messages.last, anchor: .bottom)
                        //                            }
                        //                        } else {
                        //                            withAnimation {
                        //                                proxy.scrollTo(chatService.messages.last, anchor: .bottom)
                        //                            }
                        //                        }
                    }
                    .onAppear {
                        withAnimation {
                            proxy.scrollTo(chatService.messages.last, anchor: .bottom)
                        }
                    }
                    .onChange(of: keyboardObserver.keyboardHeight) { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation {
                                proxy.scrollTo(chatService.messages.last, anchor: .bottom)
                            }
                        }
                        
                    }
                    
                }
                .padding(.top,30)
                
                // send new message
                VStack {
                    HStack {
                        
                        ZStack(alignment: .topLeading) {
                            
                            ClearBackgroundTextEditor(text: $newMessage)
                                .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 50)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil) // Allows an unlimited number of lines
                                .padding(.horizontal, 4)
                                .padding(.top, 5)
                                .background(Color.clear)
                            
                            if newMessage.isEmpty {
                                Text("Send a message")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                                    .background(Color.clear)
                            }
                        }
                        .background(Color.clear)
                        
                        
                        Button(action: sendMessage)   {
                            Image("ic_send")
                                .resizable()
                                .padding(10)
                                .frame( width: 50, height: 50)
                            
                        }
                        .background(hexToColor(hex: "#007D40"))
                        .cornerRadius(15)
                    }
                    .background(.clear)
                    .padding(.all, 10)
                    //                    .overlay {
                    //                        RoundedRectangle(cornerRadius: 35)
                    //                            .stroke(.gray, lineWidth: 1)
                    //
                    //                    }
                }
                
                .background(hexToColor(hex: "#F9F9F7"))
                .cornerRadius(15)
                .padding()
                
            }
            //            if chatService.isLoading  {
            //                CustomProgressView()
            //            }
        }.onAppear() {
            newMessage = message
            connect()
            chatService.getPreviousMessages(userId: "\(remoteUserId)", page: 0)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: remoteUserName))
        //            .navigationBarTitleDisplayMode(.inline)
        //            .navigationBarHidden(true)
        .onDisappear() {
        }
    }
    
    func sendMessage() {
        
        if !newMessage.isEmpty{
            let dic : NSDictionary = ["message" : newMessage, "receiver" : remoteUserId]
            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8) ?? ""
            ChatClient.shared.sendMessage(jsonString)
            newMessage = ""
        }
    }
    
    func connect() {
        // ChatClient.shared.connect()
        //        ChatClient.shared.receiveMessage { message in
        //            var messageModel = ChatMessageModel(id: message.id, sender: 0, text: message.lastMessage, createdAt: "")
        //            if message.user1.id == myId || message.user2.id == myId {
        //                if message.receiverID == remoteUserId {
        //                    messageModel.sender = myId
        //                } else{
        //                    messageModel.sender = remoteUserId
        //                }
        //                chatService.addNewMessage(message: messageModel)
        //            }
        //
        //        }
        ChatClient.shared.delegate = self
        
    }
    
}


import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published private(set) var keyboardHeight: CGFloat = 0
    
    let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
    
    let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ -> CGFloat in 0 }
    
    init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.keyboardHeight, on: self)
    }
}


//#Preview {
//    ContentView()
//}

