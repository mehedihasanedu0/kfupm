//
//  AddUserModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/6/24.
//

import Foundation


struct AddUserModel: Codable,Identifiable {
    
    let id: Int
    let lastLogin: String?
    let description: String?
    let designation: String?
    let username: String?
    let uuid: String?
    let email: String?
    let phoneNumber: String?
    let languagePreferences: String?
    let role: String?
    let govtIdOrIqamaNo: String?
    let fullName: String?
    let firstName: String?
    let lastName: String?
    let cv: String?
    let isActive: Bool?
    let status: String?
    let isCloseAccount: Bool?
    let isDelete: Bool?
    let image: String?
    let userType: Int?
    let groups: [String]?
    let userPermissions: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case lastLogin = "last_login"
        case description
        case designation
        case username
        case uuid
        case email
        case phoneNumber = "phone_number"
        case languagePreferences = "language_preferences"
        case role
        case govtIdOrIqamaNo = "govt_id_or_iqama_no"
        case fullName = "full_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case cv
        case isActive = "is_active"
        case status
        case isCloseAccount = "is_close_account"
        case isDelete = "is_delete"
        case image
        case userType = "user_type"
        case groups
        case userPermissions = "user_permissions"
    }
}
