//
//  SurveyAnswerSubmitModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/7/24.
//

import Foundation

struct SurveySubmitInfo: Codable {
    let survey_id: Int
    let survey_answer: String
}

struct SurveyAnswerSubmitModel: Codable {
    let course_id: Int
    let survey_submit_info: [SurveySubmitInfo]
}
