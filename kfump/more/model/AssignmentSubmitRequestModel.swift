//
//  AssignmentSubmitRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 4/6/24.
//

import Foundation

struct AssignmentSubmitRequestModel: Codable {
    var lecture_id: Int
    var assignment_submit_info: AssignmentSubmitInfo
}
struct AssignmentSubmitInfo: Codable {
    var file: String
}

