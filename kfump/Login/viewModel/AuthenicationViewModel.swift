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
    
    private let authenticationService: AuthenticationService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    
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
                self?.dialogMessage = user.message ?? ""
                completion(true)
            })
            .store(in: &cancellables)
        
        
    }
        
    
    func otpVerify(body: OtpModel, completion: @escaping (Bool) -> Void) {
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
                self?.dialogMessage = user.message ?? ""
                shared.set(user.token, forKey: TOKEN_D)
                shared.set(true, forKey: IS_LOGIN_D)
                completion(true)
            })
            .store(in: &cancellables)
        
        
    }
    
    
}
