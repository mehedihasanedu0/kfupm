////
////  ChatView.swift
////  kfump
////
////  Created by Mehedi Hasan on 21/6/24.
////
//
//import SwiftUI
//
//struct ChatView: View {
//    
//    @StateObject var getInboxData = ChatViewModel()
//    isNavigateToCourseDetailsView
//    
//    var body: some View {
//        ZStack {
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(alignment: .leading, spacing: 0) {
//                    ForEach(getInboxData.messageInboxItems, id: \.userId) { item in
//                        //                                let user = item.user1?.id == selfId ? item.user2 : item.user1
//                        //                                let userSeen = item.user1?.id == selfId ? item.user2_seen : item.user1_seen
//                        singleRoomView
//                            .onTapGesture {
//                                self.isTabBarHidden = true
//                            }
////                        NavigationLink(destination: MainChatView(remoteUserName: item.displayName , remoteUserId: item.userId , message: "").onAppear{
////                            
////                        }) {
////                            
////                        }
////                        .onDisappear{
////                            //                                    self.isTabBarHidden = false
////                        }
//                    }
//                }
//            }.onAppear {
//                self.isTabBarHidden = false
//                ChatClient.shared.connect()
//                ChatClient.shared.delegate = self
//                //                        ChatClient.shared.receiveMessage { message in
//                //                            getInboxData.getInboxMessages()
//                //                        }
//            }
//            .frame(alignment: .leading)
//            .padding(.horizontal, 8)
//            .padding(.vertical, 15)
//            .background(.white)
//        }
//        .padding(.horizontal, 13)
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        .navigationDestination(isPresented: $isNavigateToCourseDetailsView, destination: { CourseDetailsView(courseId: courseId).navigationBarBackButtonHidden(true) })
//    }
//    
//    var singleRoomView: some View {
//        VStack {
//            HStack {
//                Image(systemName: "person.circle.fill")
//                    .font(.system(size: 40))
//                    .foregroundColor(.blue)
//                
//                VStack(alignment: .leading) {
//                    HStack{
//                        Text(item.displayName )
//                            .foregroundColor(.black)
//                            .font(.headline)
//                        Spacer()
//                        Text(item.lastMessageAt )
//                            .font(Font.custom("SST Arabic", size: 14))
//                            .multilineTextAlignment(.trailing)
//                            .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.22).opacity(0.4))
//                    }
//                    
//                    Text(item.lastMessage )
//                        .font(.body)
//                        .lineLimit(2)
//                        .foregroundColor(item.seen ? .primary : .secondary)
//                }
//                Spacer()
//                if !(item.seen ) {
//                    Image(systemName: "circle.fill")
//                        .foregroundColor(.red)
//                        .font(.system(size: 10))
//                }
//            }
//            .padding(.vertical, 4)
//            Divider().padding(.leading, 50)
//        }.padding(.vertical, 4)
//    }
//}
//
//
////#Preview {
////    ChatView()
////}
