//
//  HomeRepositoryService.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/4/24.
//

import Foundation
import Combine

class HomeRepositoryService {
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func getCourses() -> AnyPublisher<CourseListResponse, Error> {
        let url = URL(string: BASE_URL + "/course/browse-course-list/?page=1&limit=25")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }
    
    func getProfileDetails() -> AnyPublisher<CourseListResponse, Error> {
        let url = URL(string: BASE_URL + profileEndPoint)
        return networkClient.getRequest(url: url, headerType: .APIRequestWithToken)
    }
    
    
    
}
