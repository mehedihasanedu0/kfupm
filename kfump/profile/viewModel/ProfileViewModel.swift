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
    
    @AppStorage(Keys.USER_NAME.rawValue) var userName: String?
    @AppStorage(Keys.USER_PROFILE.rawValue) var userProfilePicture: String?
    
    private let profileService: ProfileService
    private var cancellables = Set<AnyCancellable>()
    private let networkClient : NetworkClientForMultipart
    
    @Published var isLoading = false
    @Published var isLoadingCloseView = false
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    @Published var isProfileUpdated = false
    
    @Published var profileData : ProfileData!
    
    @Published var imageUrl: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var emailAddress: String = ""
    @Published var phoneNumber: String = ""
    @Published var govtId: String = ""
    @Published var typeOfUser: Int = 0
    
    @Published var userTypeList = [UserType]()
    @Published var paymentHistoryList = [PaymentHistoryResponseModel.PaymentHistory]()
    @Published var userTypeOptionList = [String]()
    
    init(profileService: ProfileService = ProfileService(),networkClient: NetworkClientForMultipart = NetworkClientForMultipart()) {
        self.profileService = profileService
        self.networkClient = networkClient
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func getProfileData(userUUID: String,completion: @escaping (Bool) -> Void) {
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
                self?.typeOfUser = data.data?.userType ?? 0
                self?.imageUrl = data.data?.image ?? ""
                self?.updateUI(with: data.data!)
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
            if data.firstName == nil {
                self.userName = data.fullName ?? ""
                if self.nameComponents.count == 2 {
                    self.firstName = self.nameComponents[0]
                    self.lastName = self.nameComponents[1]
                }
            } else {
                self.userName = "\(data.firstName ?? "") \(data.lastName ?? "")"
            }
            
        }
    }
    
    var nameComponents: [String] {
        userName?.split(separator: " ").map(String.init) ?? []
    }
    
    func getUserTypeList(completion: @escaping (Bool) -> Void) {
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
                self?.getUserTypeOptionList(data.data)
                completion(data.success)
            })
            .store(in: &cancellables)
        
        
    }    
    
    
    func colseAccount(body: CloseAccountRequestModel,completion: @escaping (Bool) -> Void) {
        isLoadingCloseView = true
        profileService.colseAccount(body: body)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoadingCloseView = false
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
                print("Colosed user \(data)")
                self?.dialogMessage = data.message ?? ""
                self?.isLoadingCloseView = false
                completion(data.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }
    
    
    private func getUserTypeOptionList(_ typeList: [UserType]) {
        for type in typeList {
            self.userTypeOptionList.append(type.userType ?? "")
        }
    }
    
    func fetchDataForUpdateProfileData(uuId: String,parameter : [String : Any]) {
        
        isLoading = true
        isProfileUpdated = false
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
                self.isProfileUpdated = model.success ?? false
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
                self.isProfileUpdated =  false
                self.dialogMessage = model.message ?? ""
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func fetchImageData(_ imageUrl: String) {
        
        if let url = URL(string: imageUrl) {
            print("Encoded URL: \(url)")
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                let base64String = data.base64EncodedString()
                DispatchQueue.main.async {
                    self.userProfilePicture = base64String
                }
            }.resume()
            
        } else {
            print("Failed to encode URL")
        }
        
        
    }
    
    func paymentHistory() {
        isLoadingCloseView = true
        profileService.paymentHistory()
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoadingCloseView = false
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
                self?.dialogMessage = data.message
                self?.paymentHistoryList = data.data
            })
            .store(in: &cancellables)
        
        
    }
    
}
