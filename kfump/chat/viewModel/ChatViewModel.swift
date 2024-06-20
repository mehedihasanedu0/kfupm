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
    
    init(chatService: ChatService = ChatService()) {
        self.chatService = chatService
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
