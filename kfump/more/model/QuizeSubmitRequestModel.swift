//
//  QuizeSubmitRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/6/24.
//

import Foundation

struct QuizeSubmitRequestModel: Codable {
    var lecture_id: Int
    var quiz_question_answer_info: [QuizQuestionAnswerInfo]
    
    struct QuizQuestionAnswerInfo: Codable {
        var question_id: Int
        var question_answer: String
    }
}
