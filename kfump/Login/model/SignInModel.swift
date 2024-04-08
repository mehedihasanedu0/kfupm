//
//  SignInModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 8/4/24.
//

import Foundation

struct SignInModel: Codable {
    
    let username: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
}

