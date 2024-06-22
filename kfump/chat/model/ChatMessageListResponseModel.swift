//
//  ChatMessageListResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 22/6/24.
//

import Foundation

struct ChatMessageListResponseModel: Codable {
    var message: String?
    var timestamp: String?
    var items: [ChatMessage]?
    var metadata: PaginationMetadata?
}

// Chat message model
struct ChatMessage: Codable, Hashable {
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var text: String?
    var chatRoom: Int?
    var sender: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case text
        case chatRoom = "chat_room"
        case sender
    }
}

// Metadata model
struct PaginationMetadata: Codable {
    let pagination: MessagePagination
}

// Pagination model
struct MessagePagination: Codable {
    let offset: Int
    let limit: Int
    let previousOffset: Int
    let nextOffset: Int
    let currentPage: Int
    let pageCount: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case previousOffset = "previousOffset"
        case nextOffset = "nextOffset"
        case currentPage = "currentPage"
        case pageCount = "pageCount"
        case totalCount = "totalCount"
    }
}
