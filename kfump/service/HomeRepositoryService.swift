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
    var isLogin = false
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
        isLogin = shared.object(forKey: Keys.IS_LOGIN_D.rawValue) as? Bool ?? false
    }
    
    func getCourses() -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: URL.courseList)
        return networkClient.getRequest(url: url, headerType: isLogin ? .APIRequestWithToken : .APIRequestWithNoHeader)
    }    
    
    func getCoursesWithStatus(status: String = "") -> AnyPublisher<EnrolledCourseResponseModel, Error> {
        let url = URL(string: "\(URL.courseListWithStatus)&status=\(status)")
        return networkClient.getRequest(url: url, headerType: isLogin ? .APIRequestWithToken : .APIRequestWithNoHeader)
    }
    
    
    func getCoursesBySearchKey(searchKey: String) -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: BASE_URL + "/course/browse-course-list/?search=\(searchKey)&page=1&limit=100")
        return networkClient.getRequest(url: url, headerType: isLogin ? .APIRequestWithToken : .APIRequestWithNoHeader)
        
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
