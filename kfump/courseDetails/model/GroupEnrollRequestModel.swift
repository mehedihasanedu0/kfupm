//
//  GroupEnrollSingleRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/5/24.
//

import Foundation

struct GroupEnrollRequestModel: Codable {
    
    let courseId: Int
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_enrolled_id"
        case email = "email"
    }
}
