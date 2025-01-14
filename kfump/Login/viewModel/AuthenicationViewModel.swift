//
//  AuthenicationViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/4/24.
//

import Foundation


import Foundation
import Combine
import SwiftUI

class AuthenicationViewModel : ObservableObject {
    
    @AppStorage(Keys.IS_LOGIN_D.rawValue) var isLogin: Bool?
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    @AppStorage(Keys.TOKEN_D.rawValue) var userToken: String?
    @AppStorage(Keys.USER_ID.rawValue) var userId: Int?
    @AppStorage(Keys.refreshToken.rawValue) var refreshToken: String?
    
    private let authenticationService: AuthenticationService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    @Published var token = ""
    
    
    init(authenticationService: AuthenticationService = AuthenticationService()) {
        self.authenticationService = authenticationService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    
    func signUp(body: SignUpModel, completion: @escaping (Bool) -> Void) {
        isLoading = true
        authenticationService.signUp(body: body)
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
                self?.isLoading = true
                if user.details != nil && ((user.details?.count ?? 0) > 0) {
                    self?.dialogMessage = (user.details?[0].path == "Password") ? ("\(user.details?[0].path ?? "") : " + (user.details?[0].message ?? "")) : (user.details?[0].message ?? "")
                } else {
                    self?.dialogMessage = user.message ?? ""
                }
                completion(user.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }
        
    
    func otpVerify(body: OtpModel,isAutoLogin: Bool = false, completion: @escaping (Bool) -> Void) {
        isLoading = true
        authenticationService.otpVerify(body: body)
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
                self?.isLoading = true
                self?.token = user.token ?? ""
                if user.details != nil && ((user.details?.count ?? 0) > 0) {
                    self?.dialogMessage = user.details?[0].message ?? ""
                } else {
                    self?.dialogMessage = user.message ?? ""
                }
                
                if user.success ?? false && isAutoLogin {
                    self?.userToken = user.access_token ?? ""
                    self?.refreshToken = user.refresh_token ?? ""
                    self?.isLogin = true
                    self?.userUUID =  user.data?.uuid ?? ""
                    self?.userId =  user.data?.id ?? 0
                }
                completion(user.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }        
    
    func signIn(body: SignInModel, completion: @escaping (Bool) -> Void) {
        isLoading = true
        authenticationService.signIn(body: body)
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
                
                self?.isLoading = true
                if user.details != nil && ((user.details?.count ?? 0) > 0) {
                    self?.dialogMessage = user.details?[0].message ?? ""
                } else {
                    self?.dialogMessage = user.message ?? ""
                }
                
                if user.success ?? false {
                    self?.userToken = user.access_token ?? ""
                    self?.refreshToken = user.refresh_token ?? ""
                    self?.isLogin = true
                    self?.userUUID =  user.data?.uuid ?? ""
                    self?.userId =  user.data?.id ?? 0
                }
                
                completion(user.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }    
    
    func forgetPassword(body: ForgetPasswordRequestModel, completion: @escaping (Bool) -> Void) {
        isLoading = true
        authenticationService.forgetPassword(body: body)
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
                
                self?.isLoading = true
                if user.details != nil && ((user.details?.count ?? 0) > 0) {
                    self?.dialogMessage = user.details?[0].message ?? ""
                } else {
                    self?.dialogMessage = user.message ?? ""
                }
                
                
                completion(user.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }
    
    func resetPassword(body: ResetPasswordRequestModel, completion: @escaping (Bool) -> Void) {
        isLoading = true
        authenticationService.resetPassword(body: body)
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
                
                self?.isLoading = true
                if user.details != nil && ((user.details?.count ?? 0) > 0) {
                    self?.dialogMessage = user.details?[0].message ?? ""
                } else {
                    self?.dialogMessage = user.message ?? ""
                }
                
                completion(user.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }  
    
    
    func refreshToken(body: RefreshTokenRequestModel) {
        isLoading = true
        authenticationService.refreshToken(body: body)
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
                
                self?.userToken = user.access_token ?? ""
                self?.refreshToken = user.refresh_token ?? ""
                
            })
            .store(in: &cancellables)
        
        
    }
    
    func changePassword(userUUID: String,body: ChangePasswordRequestModel,completion: @escaping (Bool) -> Void) {
        isLoading = true
        authenticationService.changePassword(userUUID: userUUID,body: body)
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
                self?.isLoading = false
                if data.details != nil && ((data.details?.count ?? 0) > 0) {
                    self?.dialogMessage = data.details?[0].message ?? ""
                } else {
                    self?.dialogMessage = data.message ?? ""
                }
                print("self?.dialogMessage => \(self?.dialogMessage)")
                completion(data.success ?? false)
            })
            .store(in: &cancellables)
        
        
    }
    
    
}
