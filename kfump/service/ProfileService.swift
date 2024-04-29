//
//  ProfileService.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/4/24.
//

import Foundation
import SwiftUI
import Combine

class ProfileService {
    
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func profileInfo(userUUID: String) -> AnyPublisher<ProfileInfoModel, Error> {
        let url = URL(string: BASE_URL + "/user/profile/\(userUUID)/")
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }
    
    func userTypeList() -> AnyPublisher<UserTypeListModel, Error> {
        let url = URL(string: URL.userType)
        return networkClient.getRequest(url: url,headerType: .APIRequestWithNoHeader)
        
    }
    
    func colseAccount(body: CloseAccountRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: "\(URL.colseAccount)\(userUUID ?? "")/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.putRequest(url: url,body: data,headerType: .APIRequestWithToken)
        
    }
 
}
