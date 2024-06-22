//
//  NewsEvent.swift
//  kfump
//
//  Created by Mehedi Hasan on 22/6/24.
//

import Foundation

struct NewsEvent: Codable, Identifiable {
    static func == (lhs: NewsEvent, rhs: NewsEvent) -> Bool {
        return true
    }
    
    var id = UUID()
    let success: Bool
    let messsage: String
    let count: Int
    let links: Links
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let title, titleAr: String
    let images: Images

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleAr = "title_ar"
        case images
    }
}

// MARK: - Images
struct Images: Codable {
    let id: Int
    let image: String
}

// MARK: - Links
struct Links: Codable {
    let next, previous: JSONNull?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
