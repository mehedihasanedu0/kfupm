//
//  ChatRoomListResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/6/24.
//

import Foundation

struct ChatRoomListResponse: Codable {
    let message: String?
    let timestamp: String?
    let items: [ChatItem]
}

// MARK: - ChatItem
struct ChatItem: Codable {
    let id: Int
    let sender: SenderUser
    let receiver: SenderUser
    let user1: Int?
    let user2: Int?
    let user1Seen: Bool?
    let user2Seen: Bool?
    let lastMessage: String?
    let user1IsFavourite: Bool?
    let user2IsFavourite: Bool?
    let userIsFavourite: Bool?
    let lastMessageAt: String?

    enum CodingKeys: String, CodingKey {
        case id, sender, receiver
        case user1 = "user1"
        case user2 = "user2"
        case user1Seen = "user1_seen"
        case user2Seen = "user2_seen"
        case lastMessage = "last_message"
        case user1IsFavourite = "user1_is_favourite"
        case user2IsFavourite = "user2_is_favourite"
        case userIsFavourite = "user_is_favourite"
        case lastMessageAt = "last_message_at"
    }
}

// MARK: - User
struct SenderUser: Codable {
    let id: Int
    let lastLogin: String?
    let dateJoined: String?
    let username: String?
    let uuid: String?
    let email: String?
    let phoneNumber: String?
    let languagePreferences: String?
    let role: String?
    let govtIdOrIqamaNo: String?
    let fullName: String?
    let firstName: String?
    let lastName: String?
    let cv: String?
    let isActive: Bool?
    let isStaff: Bool?
    let isSuperuser: Bool?
    let status: String?
    let isCloseAccount: Bool?
    let isDelete: Bool?
    let image: String?
    let userType: String?
    let groups: [String]?
    let userPermissions: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case lastLogin = "last_login"
        case dateJoined = "date_joined"
        case username, uuid, email
        case phoneNumber = "phone_number"
        case languagePreferences = "language_preferences"
        case role
        case govtIdOrIqamaNo = "govt_id_or_iqama_no"
        case fullName = "full_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case cv
        case isActive = "is_active"
        case isStaff = "is_staff"
        case isSuperuser = "is_superuser"
        case status
        case isCloseAccount = "is_close_account"
        case isDelete = "is_delete"
        case image
        case userType = "user_type"
        case groups
        case userPermissions = "user_permissions"
    }
}
