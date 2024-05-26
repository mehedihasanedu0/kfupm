//
//  CourseRatingRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/5/24.
//

import Foundation

struct CourseRatingRequestModel: Codable {
    let rate: Int
    let description: String
    let course: Int
}
