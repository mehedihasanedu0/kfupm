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
    var data: ProfileData?
    
}

struct ProfileData: Codable {
    var id: Int?
    var lastLogin: String?
    var description: String?
    var designation: String?
    var username: String?
    var uuid: String?
    var email: String?
    var phoneNumber: String?
    var languagePreferences: String?
    var role: String?
    var govtIdOrIqamaNo: String?
    var fullName: String?
    var firstName: String?
    var lastName: String?
    var cv: String?
    var status: String?
    var isCloseAccount: Bool
    var isDelete: Bool?
    var image: String?
    var userType: Int?
    var groups: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case id, username, uuid, email, status, groups
        case fullName = "full_name"
        case lastLogin = "last_login"
        case languagePreferences = "language_preferences"
        case phoneNumber = "phone_number"
        case role, cv, image
        case userType = "user_type"
        case description, designation
        case govtIdOrIqamaNo = "govt_id_or_iqama_no"
        case firstName = "first_name"
        case lastName = "last_name"
        case isCloseAccount = "is_close_account"
        case isDelete = "is_delete"
    }
}
