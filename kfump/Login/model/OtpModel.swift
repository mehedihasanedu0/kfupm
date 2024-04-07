//
//  OtpModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 8/4/24.
//

import Foundation


struct OtpModel: Codable {
    let emailOrPhone: String
    let otpCode: String
    
    enum CodingKeys: String, CodingKey {
        case emailOrPhone = "email_or_phone"
        case otpCode = "otp_code"
    }
}
