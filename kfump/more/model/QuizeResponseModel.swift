//
//  QuizeResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 4/7/24.
//

import Foundation


struct QuizeResponseModel: Codable {
    let success: Bool?
    let message: String?
    let timestamp: String?
    let data: QuizeResponseData?
}

struct QuizeResponseData: Codable {
    let id: Int
    let created_at: String?
    let updated_at: String?
    let title: String?
    let description: String?
    let file: String?
    let course: Int?
    let class_type: Int?
    let class_type_name: String?
    let quiz_info: [QuizInfo]?
    let is_submit: Bool?
}

struct QuizInfo: Codable {
    let id: Int?
    let question: String?
    let question_answer: String?
}
