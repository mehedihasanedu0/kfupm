//
//  ProfileUpdateRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 24/4/24.
//

import Foundation

struct ProfileUpdateRequestModel: Codable {
    
    let govtIdOrIqamaNo: String?
    let firstName: String?
    let lastName: String?
    var isCloseAccount: String?
    var isDelete: String?
    var userType: String?
    
}
