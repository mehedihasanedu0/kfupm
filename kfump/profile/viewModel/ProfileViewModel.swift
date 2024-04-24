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
    private let networkClient : NetworkClientForMultipart
    
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
    
    @Published var userTypeList = [UserType]()
    
    init(profileService: ProfileService = ProfileService(),networkClient: NetworkClientForMultipart = NetworkClientForMultipart()) {
        self.profileService = profileService
        self.networkClient = networkClient
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
    

    private func updateUI(with data: ProfileData) {
        DispatchQueue.main.async {
            self.firstName = data.firstName ?? ""
            self.lastName = data.lastName ?? ""
            self.emailAddress = data.email ?? ""
            self.phoneNumber = data.phoneNumber ?? ""
            self.govtId = data.govtIdOrIqamaNo ?? ""
        }
    }
    
    func getUserTypeList() {
        isLoading = true
        isSucess = false
        profileService.userTypeList()
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
                self?.userTypeList = data.data
                self?.isLoading = true
            })
            .store(in: &cancellables)
        
        
    }
    
    func fetchDataForUpdateProfileData(uuId: String,parameter : [String : Any]) {
        
        isLoading = true
        isSucess = false
        guard let url = URL(string: "\(URL.profileUpdate)\(uuId)/") else {
            fatalError("URl was incorrect")
        }
        
        print(url)
        
        networkClient.postMultipartData(url: url, parameter: parameter, httpMethod:  HttpMethod.put.rawValue) { (result) in
        
            DispatchQueue.main.async {
                self.isLoading = false
            }
            switch result {
            
            case .success(let data, let status):
                
                switch status {
                case HTTPStatusCodes.OK:
                    self.successWith(data: data)
                    break
                   
                case HTTPStatusCodes.Accepted:
                    self.successWith(data: data)
                    break
                   
                
                case HTTPStatusCodes.Created:
                    self.successWith(data: data)
                    
                    break
                    
                case HTTPStatusCodes.BadRequest:
                    self.badRequestWith(data: data)
                    break
                    
                default:
                    break
                }
                break
                
            case .failure(let error):
                print(error)
                break
            }
            
        }
        
       
    }
    
    func successWith(data: Data ) {
        JSONDecoder.decodeData(model: ProfileInfoModel.self, data) {(result) in
            switch result {
            case .success(let model):
                self.isSucess = model.success ?? false
                self.dialogMessage = model.message ?? ""
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func badRequestWith(data: Data ) {
        JSONDecoder.decodeData(model: BadRequest.self, data) {(result) in
            switch result {
            case .success(let model):
                self.isSucess =  false
                self.dialogMessage = model.message ?? ""
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
