//
//  ForgetPasswordResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/4/24.
//

import Foundation

struct ForgetPasswordResponseModel: Codable {
    
    let success: Bool?
    let message: String?
    let data: String?
    var details: [Details]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
}

