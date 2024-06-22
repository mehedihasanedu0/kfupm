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
    @AppStorage(Keys.USER_ID.rawValue) var userId: String?
    @AppStorage(Keys.IS_LOGIN_D.rawValue) var isLogin: Bool?
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func createReportedIssue(_ body: ReportedAnIssueRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: "\(URL.courseDetails)\("")/")
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }    
    
    func enrollment(_ body: EnrolledRequestModel) -> AnyPublisher<CourseEnrolled, Error> {
        let url = URL(string: URL.enrolledCourse)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }    
    
    func singlePayment(_ body: SinglePaymentRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.cashPayment)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    } 
    
    func groupPayment(_ body: GroupEnrollRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.enrolledGroup)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }
    
    func courseDetails(courseId: Int) -> AnyPublisher<CourseDetailsResponseModel, Error> {
        let url = URL(string: "\(URL.courseDetails)\(courseId)/")
        print(isLogin ?? false)
        return networkClient.getRequest(url: url,headerType: (isLogin ?? false) ? .APIRequestWithToken : .APIRequestWithoutToken)
    }
    
    func ongoingCourseDetails(courseId: Int) -> AnyPublisher<OngoingCourseDetailsResponseModel, Error> {
        let url = URL(string: "\(URL.ongoingCourseDetails)\(courseId)/")
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }
    
    func createReview(_ body: CourseRatingRequestModel) -> AnyPublisher<CourseRatingResponseModel, Error> {
        let url = URL(string: URL.createReview)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }    
    
    
    func readLecture(_ lectureId: Int) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: "\(URL.readLecture)\(lectureId)/" )
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }    
    
    func getQuizeList(_ lectureId: Int) -> AnyPublisher<QuizeResponseModel, Error> {
        let url = URL(string: "\(URL.quiseList)\(lectureId)&user=\(userId!)" )
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }  
    
    func viewGirds(_ courseId: Int) -> AnyPublisher<TraineeGradesResponseModel, Error> {
        let url = URL(string: "\(URL.viewGirds)\(courseId)" )
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }   
    
    func submitQuizeAnswer(_ body : QuizeSubmitRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.quiseAns)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }   
    
    func submitAssignment(_ body : AssignmentSubmitRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.assignmentSubmit)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }    
    
    func courseStatusChange(_ body : CourseStatusRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.courseStatusChange)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }
    
}
