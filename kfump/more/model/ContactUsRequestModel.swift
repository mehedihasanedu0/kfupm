//
//  ContactUsRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/5/24.
//

import Foundation

struct ContactUsRequestModel: Codable {
    let full_name: String
    let email: String
    let subject: String
}
