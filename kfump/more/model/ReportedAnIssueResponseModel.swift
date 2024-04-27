//
//  ReportedAnIssueResponseModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation


struct ReportedAnIssueResponseModel: Codable {
    let success: Bool?
    let message: String?
    let data: [IssueReport]?

}

struct IssueReport: Codable,Identifiable {
    let id: Int
    let createdAt: String?
    let updatedAt: String?
    let subject: String?
    let description: String?
    let status: String?
    let user: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subject
        case description
        case status
        case user
    }
}
