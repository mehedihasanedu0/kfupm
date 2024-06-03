//
//  CourseStatusRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 4/6/24.
//

import Foundation

struct CourseStatusRequestModel: Codable {
    
    let courseId: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_id"
        case status = "status"
    }
}
