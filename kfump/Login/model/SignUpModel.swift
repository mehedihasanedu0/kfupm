//
//  SignUpModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/4/24.
//

import Foundation


struct SignUpModel: Codable {
    
    let fullName: String?
    let phoneNumber: String?
    let email: String?
    let govtIdOrIqamaNo: String?
    let password: String?
    let confirmPassword: String?
    let role: String = "TRAINEE"
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case email = "email"
        case govtIdOrIqamaNo = "govt_id_or_iqama_no"
        case password = "password"
        case confirmPassword = "confirm_password"
        case role = "role"
    }
    
    
}
