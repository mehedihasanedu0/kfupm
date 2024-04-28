//
//  CourseService.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/4/24.
//

import Foundation
import SwiftUI
import Combine

class CourseService {
    
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func createReportedIssue(_ body: ReportedAnIssueRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: "\(URL.courseDetails)\("")/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }
    
    func courseDetails(courseId: Int) -> AnyPublisher<CourseDetailsResponseModel, Error> {
        let url = URL(string: "\(URL.courseDetails)\(courseId)/")
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }
    
}
