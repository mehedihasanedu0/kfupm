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
    
    func getCourses() -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: BASE_URL + "/course/browse-course-list/?page=1&limit=100")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }    
    
    func getCoursesBySearchKey(searchKey: String) -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: BASE_URL + "/course/browse-course-list/?search=\(searchKey)&page=1&limit=100")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
        
    }
    
    func getFilterCategory() -> AnyPublisher<FilterCategoryResponse, Error> {
        let url = URL(string: BASE_URL + "/course/category/")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }
    
    func getFilterAvailability() -> AnyPublisher<FilterAvailabilityResponse, Error> {
        let url = URL(string: BASE_URL + "/course/availability/")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }
    
    func getProfileDetails() -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: BASE_URL + profileEndPoint)
        return networkClient.getRequest(url: url, headerType: .APIRequestWithToken)
    }
    
    
    
}
