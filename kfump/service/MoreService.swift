//
//  MoreService.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation
import SwiftUI
import Combine

class MoreService {
    
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    
    private let networkClient: NetworkClient
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func createContactUs(_ body: ContactUsRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.contactUs)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }    
    
    func createReportedIssue(_ body: ReportedAnIssueRequestModel) -> AnyPublisher<CommonSuccessResponseModel, Error> {
        let url = URL(string: URL.createReportAnIssue)
        guard let data = try? JSONEncoder().encode(body) else { fatalError("Error encoding uservm!") }
        return networkClient.postRequest(url: url,body: data,headerType: .APIRequestWithToken)
    }
    
    func getReportedIssue() -> AnyPublisher<ReportedAnIssueResponseModel, Error> {
        let url = URL(string: "\(URL.getAllreportIssue)\(userUUID ?? "")/")
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }    
    
    
    func getAttendanceHistory() -> AnyPublisher<AttendanceListResponseModel, Error> {
        let url = URL(string: URL.attendanceHistory)
        return networkClient.getRequest(url: url,headerType: .APIRequestWithToken)
    }
    
}
