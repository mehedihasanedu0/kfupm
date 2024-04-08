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
        let url = URL(string: BASE_URL + "/user/registration/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
    }
    
    func signIn(body: SignInModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: BASE_URL + "/user/login/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
        
    }
    
    func otpVerify(body: OtpModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: BASE_URL + "/user/otp-verify/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
    }
    
    func resetPassword() -> AnyPublisher<FilterAvailabilityResponse, Error> {
        let url = URL(string: BASE_URL + "/user/reset-password/")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }
    
    func changePassword() -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: BASE_URL + "/user/set-password/")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithToken)
    }
        
    func refreshToken() -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: BASE_URL + "/user/refresh-token/")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithToken)
    }
    
    
    
}
