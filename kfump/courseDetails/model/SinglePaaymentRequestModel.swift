//
//  SinglePaaymentRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/5/24.
//

import Foundation

struct SinglePaymentRequestModel: Codable {
    
    let courseId: Int
    let paymentMethod: String
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_enrolled_id"
        case paymentMethod = "payment_method"
    }
}
