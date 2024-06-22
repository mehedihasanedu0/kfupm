//
//  ChatViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/6/24.
//

import Combine
import SwiftUI

class ChatViewModel : ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    private let chatService: ChatService
    
    @Published var userList = [AddUserModel]()
    @Published var rooList = [ChatItem]()
    
    @Published var dialogMessageForInvite = ""
//    @Published var inboxMessages: ChatMessageListResponseModel
    @Published var messages : [ChatMessage] = []
//    @Published var inboxItems = [InboxItem]()
//    @Published var messageInboxItems = [InboxUserItem]()
//    @Published var messageInboxRowItems = [InboxUserItem]()
    
    var insideMessages = [ChatMessage]()
    
    var nextPageUrl = ""
    var pageCount = 5
    var currentCount = 1
    var messageId = 0
    
    init(chatService: ChatService = ChatService()) {
        self.chatService = chatService
//        inboxMessages = InboxResponse.init(success: true, messsage: "String", count: 1, links: SpecialOffersLinks.init(next: SpecialOffersJSONNull.init(), previous: SpecialOffersJSONNull.init()), data: [])
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    
    func getUserList() {
        isLoading = true
        chatService.getUserList()
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] user in
                self?.isLoading = false
                self?.userList = user
            })
            .store(in: &cancellables)
        
        
    }
    
    func getRoomList() {
        isLoading = true
        chatService.getRoomList()
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] room in
                self?.isLoading = false
                self?.rooList = room.items
            })
            .store(in: &cancellables)
        
        
    }
    
    func getPreviousMessages(userId: String, page:Int = 0) {
        
        chatService.getMessages(id: userId)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] messageResponse in
                self?.showingDialogAlert = true
                //                self?.nextPageUrl = messageResponse.links.next ?? ""
                
                if let weakSelf = self {
                    self?.insideMessages.append(contentsOf: messageResponse.items ?? [])
                    if weakSelf.nextPageUrl.isEmpty {
                        weakSelf.isLoading = false
                        weakSelf.messages = Array(weakSelf.insideMessages.reversed())
                    } else {
                        weakSelf.currentCount += 1
//                        weakSelf.loadMore(userId: userId)
                    }
                }
                
                self?.messages = Array(messageResponse.items?.reversed() ?? [])
                self?.dialogMessage = messageResponse.message ?? ""
                if let weakSelf = self {
                    if !weakSelf.messages.isEmpty {
                        weakSelf.messageId = weakSelf.messages[weakSelf.messages.count - 1].id ?? 0
                    }
                }
                
            })
            .store(in: &cancellables)
    }
    //
    //
    //    func getReportedIssue() {
    //        isLoading = true
    //        chatService.getReportedIssue()
    //            .handleEvents(receiveCompletion: { [weak self] value in
    //                self?.isLoading = false
    //            })
    //            .sink(receiveCompletion: { completion in
    //                switch completion {
    //                case .finished:
    //                    break
    //                case .failure(let error):
    //                    print("error \(error)")
    //                    self.error = error
    //                    self.showingDialogAlert = true
    //                    self.dialogMessage = error.localizedDescription
    //
    //                }
    //            }, receiveValue: { [weak self] data in
    //                self?.issueList = data.data ?? []
    //                self?.isLoading = true
    //            })
    //            .store(in: &cancellables)
    //
    //
    //    }
    //
    //
    //    func getAttendanceHistory() {
    //        isLoading = true
    //        chatService.getAttendanceHistory()
    //            .handleEvents(receiveCompletion: { [weak self] value in
    //                self?.isLoading = false
    //            })
    //            .sink(receiveCompletion: { completion in
    //                switch completion {
    //                case .finished:
    //                    break
    //                case .failure(let error):
    //                    print("error \(error)")
    //                    self.error = error
    //                    self.showingDialogAlert = true
    //                    self.dialogMessage = error.localizedDescription
    //
    //                }
    //            }, receiveValue: { [weak self] data in
    //                self?.attendanceHistory = data.data
    //                self?.isLoading = false
    //            })
    //            .store(in: &cancellables)
    //
    //
    //    }
    
    
}
