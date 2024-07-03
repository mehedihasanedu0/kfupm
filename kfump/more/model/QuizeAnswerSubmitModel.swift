//
//  QuizeAnswerSubmitModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 4/7/24.
//

import Foundation

struct QuizeSubmitInfo: Codable {
    let question_id: Int
    let question_answer: String
}

struct QuizeAnswerSubmitModel: Codable {
    let lecture_id: Int
    let quiz_question_answer_info: [QuizeSubmitInfo]
}
