//
//  EnrolledRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 1/5/24.
//

import Foundation


struct EnrolledRequestModel: Codable {
    
    let courseId: Int
    let enrolledType: String
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_id"
        case enrolledType = "enrolled_type"
    }
}
