//
//  MoreViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation
import Combine
import SwiftUI

class MoreViewModel : ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    private let moreService: MoreService
    
    @Published var issueList = [IssueReport]()
    
    init(moreService: MoreService = MoreService()) {
        self.moreService = moreService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func createReportedIssue(body: ReportedAnIssueRequestModel, completion: @escaping (Bool) -> Void) {
        isLoading = true
        moreService.createReportedIssue(body)
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
                if user.details != nil && ((user.details?.count ?? 0) > 0) {
                    self?.dialogMessage = (user.details?[0].path == "Password") ? ("\(user.details?[0].path ?? "") : " + (user.details?[0].message ?? "")) : (user.details?[0].message ?? "")
                } else {
                    self?.dialogMessage = user.message ?? ""
                }
                completion(user.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }
    
    
    func getReportedIssue() {
        isLoading = true
        moreService.getReportedIssue()
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
            }, receiveValue: { [weak self] data in
                self?.issueList = data.data ?? []
                self?.isLoading = true
            })
            .store(in: &cancellables)
        
        
    }
    
    
}
