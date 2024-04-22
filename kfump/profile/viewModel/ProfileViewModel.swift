//
//  ProfileViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/4/24.
//

import Foundation


import Foundation
import Combine
import SwiftUI

class ProfileViewModel : ObservableObject {
    
    
    private let profileService: ProfileService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    @Published var profileData : ProfileData!
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var emailAddress: String = ""
    @Published var phoneNumber: String = ""
    @Published var govtId: String = ""
    @Published var typeOfUser: String = ""
    
    init(profileService: ProfileService = ProfileService()) {
        self.profileService = profileService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func getProfileData(userUUID: String) {
        isLoading = true
        profileService.profileInfo(userUUID: userUUID)
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
                
                self?.updateUI(with: data.data!)
                self?.isLoading = true
            })
            .store(in: &cancellables)
        
        
    }
    
    
    func changePassword(userUUID: String,body: ChangePasswordRequestModel,completion: @escaping (Bool) -> Void) {
        isLoading = true
        profileService.changePassword(userUUID: userUUID,body: body)
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
                self?.isLoading = true
                completion(data.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }
    
    private func updateUI(with data: ProfileData) {
        DispatchQueue.main.async {
            self.firstName = data.firstName ?? ""
            self.lastName = data.lastName ?? ""
            self.emailAddress = data.email ?? ""
            self.phoneNumber = data.phoneNumber ?? ""
            self.govtId = data.govtIdOrIqamaNo ?? ""
        }
    }
    
}
