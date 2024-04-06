//
//  CategoryResponse.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/4/24.
//

import Foundation


struct FilterCategoryResponse: Codable {
    var success: Bool
    var message: String
    var timestamp: String
    var data: [Category]
}


struct Category: Codable {
   
    var id: Int
    var createdAt: String
    var updatedAt: String
    var categoryName: String
    var isSelect: Bool

    enum CodingKeys: String, CodingKey {
        case id, createdAt = "created_at", updatedAt = "updated_at", categoryName = "category_name", isSelect
    
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        categoryName = try container.decode(String.self, forKey: .categoryName)
        isSelect = try container.decodeIfPresent(Bool.self, forKey: .isSelect) ?? false
    }
}
