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
    var file: String?
    var access_token: String?
    var refresh_token: String?
    var details: [Details]?
    var data: CommonData?
}

struct Details: Codable {
    var path: String?
    var message: String?
    var uuid: String?
}

struct CommonData: Codable {
    var uuid: String?
    var id: Int?
}

