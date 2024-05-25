//
//  OngoingCourseDetailsResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/5/24.
//

import Foundation


struct OngoingCourseDetailsResponseModel: Codable {
    let success: Bool?
    let message: String?
    let timestamp: String?
    let data: [Lecture]?
    let videoCount: Int?
    let pdfCount: Int?
    let assignmentCount: Int?
    let id: Int?
    let title: String?
    let description: String?
    let isDisable: Bool?

    enum CodingKeys: String, CodingKey {
        case success, message, timestamp, data
        case videoCount = "video_count"
        case pdfCount = "pdf_count"
        case assignmentCount = "assignment_count"
        case id, title, description
        case isDisable = "is_disable"
    }
}

// MARK: - Lecture Model
struct Lecture: Codable, Identifiable {
    
    let id: Int?
    let title: String?
    let classTypeName: String?
    let test: String?
    let createdAt: String?
    let updatedAt: String?
    let surveyQuestion: String?
    let surveyCategory: Int?
    let course: Int?
    let isRead: Bool?
    let isDisable: Bool?
    let fileExtension: String?
    let fileSize: Int?
    let duration: String?
    let description: String?
    let file: String?
    let classType: Int?
    let userId: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case classTypeName = "class_type_name"
        case test
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case surveyQuestion = "survey_question"
        case surveyCategory = "survey_category"
        case course
        case isRead = "is_read"
        case isDisable = "is_disable"
        case fileExtension = "file_extension"
        case fileSize = "file_size"
        case duration
        case description
        case file
        case classType = "class_type"
        case userId = "user_id"
    }
}



