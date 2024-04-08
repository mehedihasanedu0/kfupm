//
//  HomeViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/4/24.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel : ObservableObject {
    
    private let homeRepositoryService: HomeRepositoryService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    @Published var courseList : [Course] = Course.dummyData
    @Published var courseListBySearchKey = [Course]()
    
    init(homeRepositoryService: HomeRepositoryService = HomeRepositoryService()) {
        self.homeRepositoryService = homeRepositoryService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func getCourseList() {
        isLoading = true
        homeRepositoryService.getCourses()
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
                    self.courseList = []
                }
            }, receiveValue: { [weak self] inviteeResponse in
                self?.courseList = inviteeResponse.items
                self?.isLoading = true
            })
            .store(in: &cancellables)
        
        
    }    
    
    
    func getCourseListBySearchKey(searchKey: String) {
        isLoadingBySearchKey = true
        homeRepositoryService.getCoursesBySearchKey(searchKey: searchKey)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoadingBySearchKey = false
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
                    self.courseListBySearchKey = []
                }
            }, receiveValue: { [weak self] courseResponse in
                self?.courseListBySearchKey = courseResponse.items
                self?.isLoadingBySearchKey = true
            })
            .store(in: &cancellables)
        
        
    }    
    
    
    
    
    
//    func getCourseList(completion: @escaping (Bool) -> Void) {
//        isLoading = true
//        homeRepositoryService.getCourses()
//            .handleEvents(receiveCompletion: { [weak self] value in
//                self?.isLoading = false
//            })
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self.error = error
//                    self.showingDialogAlert = true
//                    self.dialogMessage = error.localizedDescription
//                }
//            }, receiveValue: { [weak self] inviteeResponse in
//                self?.courseList = inviteeResponse.items
//                self?.isLoading = true
//            })
//            .store(in: &cancellables)
//        
//        
//    }
    
}
