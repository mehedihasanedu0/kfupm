//
//  InboxResponse.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/6/24.
//

import Foundation

struct InboxResponse: Codable {
    var success: Bool?
    var messsage: String? = ""
    var count: Int? = 0
    var links: SpecialOffersLinks?
    var data: [InboxItem] = []
}

struct InboxItem: Codable {
    var id: Int? = 0
    var user1: InboxUser?
    var user2: InboxUser?
    var last_message: String? = ""
    var last_message_at: String? = ""
    var user1_seen: Bool? = false
    var user2_seen: Bool? = false
}

struct InboxUser: Codable {
    var id: Int? = 0
    var name: String? = ""
    var profile_picture: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id, profile_picture
        case name = "displayName"
    }
}


struct InboxUserItem: Codable {
    let userId: Int
    let displayName: String
    let profilePicture: String?
    let lastMessage: String
    var seen: Bool
    var lastMessageAt: String

    enum CodingKeys: String, CodingKey {
        case userId, displayName, lastMessage
        case profilePicture
        case seen, lastMessageAt
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let chatMessageResponse = try? JSONDecoder().decode(ChatMessageResponse.self, from: jsonData)

import Foundation

// MARK: - ChatMessageResponse
struct ChatMessageResponse: Codable {
    var success: Bool?
    var messsage: String?
    var count: Int?
    var links: ChatLoadLinks
    var data: [ChatMessageModel]?
}

struct ChatLoadLinks: Codable {
    var next: String?
    var previous: String?
}

// MARK: - Datum
struct ChatMessageModel: Codable, Hashable {
    var id, sender: Int?
    var text, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, sender, text
        case createdAt = "created_at"
    }
}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let chatReceiveModel = try? JSONDecoder().decode(ChatReceiveModel.self, from: jsonData)

import Foundation

// MARK: - ChatReceiveModel
struct ChatReceiveModel: Codable {
    let type: String
    let senderID, receiverID, chatRoomID: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case type
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case chatRoomID = "chat_room_id"
        case message
    }
}
