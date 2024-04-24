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
    
    func userTypeList() -> AnyPublisher<UserTypeListModel, Error> {
        let url = URL(string: URL.userType)
        return networkClient.getRequest(url: url,headerType: .APIRequestWithNoHeader)
        
    }
 
}
