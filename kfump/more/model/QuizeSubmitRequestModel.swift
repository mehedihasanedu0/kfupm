//
//  QuizeSubmitRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/6/24.
//

import Foundation

struct QuizeSubmitRequestModel: Codable {
    
    let lecture_id: Int
    let quiz_question_answer_info: [QuizQuestionAnswerInfo]
    

}


struct QuizQuestionAnswerInfo: Codable {
    let question_id: Int
    let question_answer: String
}
