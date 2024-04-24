//
//  BadRequest.swift
//  kfump
//
//  Created by Mehedi Hasan on 24/4/24.
//

import Foundation

struct BadRequest : Codable{

    let message : String?
    let message_ar : String?
    let error : String?
    let name : String?
    let non_field_errors : [String]?
    let phone : [String]?
    let email : [String]?
    let old_password : [String]?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case message_ar = "message_ar"
        case error = "error"
        case name = "name"
        case non_field_errors = "non_field_errors"
        case phone = "phone"
        case email = "email"
        case old_password = "old_password"

    }
    
}
