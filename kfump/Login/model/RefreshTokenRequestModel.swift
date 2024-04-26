//
//  RefreshTokenRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/4/24.
//

import Foundation

struct RefreshTokenRequestModel: Codable {
    
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
