//
//  AuthenticationService.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/4/24.
//

import Foundation
import Combine

class AuthenticationService {
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func signUp(body: SignUpModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.registration)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
    }
    
    func signIn(body: SignInModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.login)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
        
    }
    
    func otpVerify(body: OtpModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.otp_verify)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
    }
    
    func resetPassword() -> AnyPublisher<FilterAvailabilityResponse, Error> {
        let url = URL(string: URL.forgetPassword)
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }
    
    func changePassword(userUUID: String,body: ChangePasswordRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: "\(URL.changePassword)\(userUUID)/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.putRequest(url: url,body: data, headerType: .APIRequestWithToken)
    }
        
    func refreshToken() -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: URL.refreshToken)
        return networkClient.getRequest(url: url, headerType: .APIRequestWithToken)
    }
    
    
    
}
