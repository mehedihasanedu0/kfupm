//
//  NotificationResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 23/6/24.
//

import Foundation

struct NotificationResponseModel: Codable {
    let timestamp: String
    let items: [NotificationItem]
    let metadata: NotificationMetadata
}

// MARK: - NotificationItem
struct NotificationItem: Codable, Identifiable {
    let id: Int
    let title, text, titleAr, textAr: String?
    let type: String?
    let resourceID: Int?
    let seen: Bool?
    let createdAt, updatedAt: String?
    let user: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, text
        case titleAr = "title_ar"
        case textAr = "text_ar"
        case type
        case resourceID = "resource_id"
        case seen
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}

// MARK: - Metadata
struct NotificationMetadata: Codable {
    let pagination: Pagination
}

