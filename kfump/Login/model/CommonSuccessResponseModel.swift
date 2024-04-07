//
//  CommonSuccessResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/4/24.
//

import Foundation


struct CommonSuccessResponseModel: Codable {
    var success: Bool?
    var timestamp: String?
    var message: String?
    var token: String?
//    var data: UserData?
}
//
//struct UserData: Codable {
//    var full_name: String
//    var email: String
//    var password: String
//    var confirm_password: String
//    var role: String
//    var phone_number: String
//}
