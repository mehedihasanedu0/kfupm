//
//  QuizeResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/5/24.
//

import Foundation

struct QuizeResponseModel: Codable {
    let success: Bool?
    let message: String?
    let timestamp: String?
    let data: [TraineeSubmission]
    let totalStudentEnroll: Int?
    let avgMark: Double?
    let standardDeviation: Double?

    enum CodingKeys: String, CodingKey {
        case success, message, timestamp, data
        case totalStudentEnroll = "total_student_enroll"
        case avgMark = "avg_mark"
        case standardDeviation = "standard_deviation"
    }
}

struct TraineeSubmission: Codable ,Identifiable {
    var id: Int?
    let date: String?
    let title: String?
    let studentName: String?
    let course: Int?
    let classType: Int?
    let classTypeName: String?
    let user: Int?
    let courseLecture: Int?

    enum CodingKeys: String, CodingKey {
        case date, title,id
        case studentName = "student_name"
        case course
        case classType = "class_type"
        case classTypeName = "class_type_name"
        case user
        case courseLecture = "course_lecture"
    }
}
