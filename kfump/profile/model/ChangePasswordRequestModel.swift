//
//  ChangePasswordModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 23/4/24.
//

import Foundation

struct ChangePasswordRequestModel: Codable {
    
    let oldPassword: String?
    let newPassword: String?
    let confirmPassword: String?
    
    enum CodingKeys: String, CodingKey {
        case oldPassword = "old_password"
        case newPassword = "new_password"
        case confirmPassword = "confirm_password"
    }
    
    
}

