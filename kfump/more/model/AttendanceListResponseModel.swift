//
//  AttendanceListResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/5/24.
//

import Foundation

struct AttendanceListResponseModel: Codable {
    let success: Bool
    let message: String
    let timestamp: String
    let data: [AttendanceData]
}

struct AttendanceData: Codable,Identifiable {
    let id: Int
    let course: Course
    let user: User
    let date: String
    let isPresent: Bool

    enum CodingKeys: String, CodingKey {
        case id, course, user, date
        case isPresent = "is_present"
    }
}

