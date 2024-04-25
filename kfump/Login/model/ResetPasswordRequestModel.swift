//
//  ResetPasswordRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/4/24.
//

import Foundation

struct ResetPasswordRequestModel: Codable {
    
    let newPassword: String?
    let conformPassword: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case newPassword = "new_password"
        case conformPassword = "confirm_password"
        case token = "token"
    }
}
