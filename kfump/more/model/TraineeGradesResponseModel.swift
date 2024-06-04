//
//  TraineeGradesResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 5/6/24.
//

import Foundation

struct TraineeGradesResponseModel: Codable {
    let success: Bool?
    let message: String?
    let timestamp: String?
    let data: [TraineeGrade]?
}

struct TraineeGrade: Codable,Identifiable {
    var id: Int?
    let date: String?
    let title: String?
    let score: Int?
    let status: String?
    let course: Int?
    let courseLecture: Int?

    enum CodingKeys: String, CodingKey {
        case date, title, score, status, course
        case courseLecture = "course_lecture"
    }
}
