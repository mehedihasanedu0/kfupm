//
//  CloseAccountRequestModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 30/4/24.
//

import Foundation


struct CloseAccountRequestModel: Codable {
    
    var isCloseAccount: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case isCloseAccount = "is_close_account"
        
    }
    
}
