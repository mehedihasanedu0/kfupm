//
//  UserTypeListModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/4/24.
//

import Foundation


struct UserTypeListModel: Codable {
    let success: Bool
    let message: String
    let data: [UserType]
}

struct UserType: Codable,Identifiable {
    let id: Int?
    let userType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userType = "user_type"
    }
}
