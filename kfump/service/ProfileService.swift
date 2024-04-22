//
//  ProfileService.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/4/24.
//

import Foundation
import Foundation
import Combine

class ProfileService {
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func profileInfo(userUUID: String) -> AnyPublisher<ProfileInfoModel, Error> {
        let url = URL(string: BASE_URL + "/user/profile/\(userUUID)/")
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }
    
    func changePassword(userUUID: String,body: ChangePasswordRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: BASE_URL + "/user/change-password/\(userUUID)/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
        
    }
    
    func otpVerify(body: OtpModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: BASE_URL + "/user/otp-verify/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data, headerType: .APIRequestWithNoHeader)
    }
}
