//
//  FilterAvailabilityResponse.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/4/24.
//

import Foundation
import Combine


struct FilterAvailabilityResponse: Codable {
    var success: Bool
    var message: String
    var timestamp: String
    var data: [Availability]
}

struct Availability: Codable {
    var id: Int
    var createdAt: String
    var updatedAt: String
    var availabilityType: String
    var isSelect: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt = "created_at", updatedAt = "updated_at", availabilityType = "availability_type", isSelect
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        availabilityType = try container.decode(String.self, forKey: .availabilityType)
        isSelect = try container.decodeIfPresent(Bool.self, forKey: .isSelect) ?? false
    }
    
}
