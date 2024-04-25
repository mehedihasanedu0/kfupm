//
//  ForgetPasswordRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/4/24.
//

import Foundation

struct ForgetPasswordRequestModel: Codable {
    
    let emailOrPhone: String?
    
    enum CodingKeys: String, CodingKey {
        case emailOrPhone = "email_or_phone"
    }
}
