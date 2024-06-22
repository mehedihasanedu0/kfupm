//
//  ChatService.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/6/24.
//

import SwiftUI
import Combine

class ChatService {
    
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    @AppStorage(Keys.USER_ID.rawValue) var userId: String?
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func getUserList() -> AnyPublisher<[AddUserModel], Error> {
        let url = URL(string: URL.userList)
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }
    
    func getRoomList() -> AnyPublisher<ChatRoomListResponse, Error> {
        let url = URL(string: URL.roomList)
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }
    
    
    func getMessages(id:String) -> AnyPublisher<ChatMessageListResponseModel, Error> {
        let url = URL(string: "\(URL.userChat)\(id)/")
        return networkClient.getRequest(url: url, headerType: .APIRequestWithToken)
    }
    
    func groupPayment(_ body: GroupEnrollRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.enrolledGroup)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }
    
    func courseDetails(courseId: Int) -> AnyPublisher<CourseDetailsResponseModel, Error> {
        let url = URL(string: "\(URL.courseDetails)\(courseId)/")
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
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
    
    
    
    
}
