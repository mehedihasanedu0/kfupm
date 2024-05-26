//
//  CourseRatingModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/5/24.
//

import Foundation

struct CourseRatingResponseModel: Codable {
    let success: Bool
    let message: String
    let timestamp: String
    let data: RatingData
}

struct RatingData: Codable {
    let rate: Double
    let course: Int
    let description: String
    let status: String
}
