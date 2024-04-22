//
//  ProfileInfoModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/4/24.
//

import Foundation

struct ProfileInfoModel: Codable {
    
    let success: Bool?
    let message: String?
    let data: ProfileData?
    
}

struct ProfileData: Codable {
    let id: Int
    let lastLogin: String?
    let description: String?
    let designation: String?
    let username: String
    let uuid: String?
    let email: String?
    let phoneNumber: String?
    let languagePreferences: String
    let role: String
    let govtIdOrIqamaNo: String?
    let fullName: String
    let firstName: String?
    let lastName: String?
    let cv: String?
    let status: String
    let isCloseAccount: Bool
    let isDelete: Bool
    let image: String?
    let userType: String?
    let groups: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id, username, uuid, email, status, groups
        case fullName = "full_name"
        case lastLogin = "last_login"
        case languagePreferences = "language_preferences"
        case phoneNumber = "phone_number"
        case role, cv, image, userType
        case description, designation
        case govtIdOrIqamaNo = "govt_id_or_iqama_no"
        case firstName = "first_name"
        case lastName = "last_name"
        case isCloseAccount = "is_close_account"
        case isDelete = "is_delete"
    }
}
