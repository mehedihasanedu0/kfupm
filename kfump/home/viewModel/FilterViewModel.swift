//
//  FilterViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/4/24.
//

import Foundation
import Combine
import SwiftUI

class FilterViewModel : ObservableObject {
    
    private let homeRepositoryService: HomeRepositoryService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
//    @Published var filterCategoryList = [Category]()
//    @Published var filterAvailabilityList = [Availability]()
    

    
    init(homeRepositoryService: HomeRepositoryService = HomeRepositoryService()) {
        self.homeRepositoryService = homeRepositoryService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func getFilterCategoryList(completion: @escaping ([Category]) -> Void) {
        isLoading = true
        homeRepositoryService.getFilterCategory()
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
            }, receiveValue: { [weak self] category in
                self?.isLoading = true
                completion(category.data)
            })
            .store(in: &cancellables)
        
        
    }
    

    
    func getFilterAvailableList(completion: @escaping ([Availability]) -> Void) {
        isLoading = true
        homeRepositoryService.getFilterAvailability()
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
            }, receiveValue: { [weak self] availability in
                self?.isLoading = true
                completion(availability.data)
            })
            .store(in: &cancellables)
        
        
    }

}
