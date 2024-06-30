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
    
    
    func getCoursesBySearchKey(searchKey: String,category: [Int] = [],availability : [Int] = []) -> AnyPublisher<CourseListResponseModel, Error> {
        var urlString = "\(URL.courseListBySearchKey)\(searchKey)"
        print("1st urlString  \(urlString)")
        print("category  \(category)")
        print("availability  \(availability)")
        
        if !category.isEmpty {
            let categoryString = category.map { "\($0)" }.joined(separator: ",")
            urlString = "\(urlString)&category=\(categoryString)"
        }
        print("1st urlString category  \(urlString)")
        
        if !availability.isEmpty {
            let availabilityString = availability.map { "\($0)" }.joined(separator: ",")
            urlString = "\(urlString)&availability=\(availabilityString)"
        }
        print("1st urlString  availability \(urlString)")
        
        print("2nd urlString  \(urlString)")
           urlString = "\(urlString)&page=1&limit=100"
           print("3rd urlString \(urlString)")
        
        var url = URL(string: urlString)
        return networkClient.getRequest(url: url, headerType: isLogin ? .APIRequestWithToken : .APIRequestWithNoHeader)
        
    }
    
    func getFilterCategory() -> AnyPublisher<FilterCategoryResponse, Error> {
        let url = URL(string: URL.filterCategory)
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }
    
    func getFilterAvailability() -> AnyPublisher<FilterAvailabilityResponse, Error> {
        let url = URL(string: URL.availability)
        return networkClient.getRequest(url: url, headerType: .APIRequestWithNoHeader)
    }
    
    func getProfileDetails() -> AnyPublisher<CourseListResponseModel, Error> {
        let url = URL(string: URL.profile)
        return networkClient.getRequest(url: url, headerType: .APIRequestWithToken)
    }
    
    
    
}
