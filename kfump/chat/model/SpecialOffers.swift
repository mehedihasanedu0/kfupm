//
//  SpecialOffers.swift
//  kfump
//
//  Created by Mehedi Hasan on 22/6/24.
//

import Foundation


// MARK: - SpecialOffers
struct SpecialOffers: Codable {
    let success: Bool
    let messsage: String
    let count: Int
    let links: SpecialOffersLinks
    let data: [SpecialOffersDatum]
}

// MARK: - Datum
struct SpecialOffersDatum: Codable {
    let id: Int
    let title, titleAr: String
    let sectors: Sectors
    let companies: Companies
    let images: SpecialOffersImages

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleAr = "title_ar"
        case sectors, companies, images
    }
}

// MARK: - Companies
struct Companies: Codable {
    let id: Int
    let company: String
    let companyAr: SpecialOffersJSONNull?

    enum CodingKeys: String, CodingKey {
        case id, company
        case companyAr = "company_ar"
    }
}

// MARK: - Images
struct SpecialOffersImages: Codable {
    let image: String?
    let id: Int?
}

// MARK: - Sectors
struct Sectors: Codable {
    let id: Int
    let sector: String
    let sectorAr: SpecialOffersJSONNull?

    enum CodingKeys: String, CodingKey {
        case id, sector
        case sectorAr = "sector_ar"
    }
}

// MARK: - Links
struct SpecialOffersLinks: Codable {
    let next, previous: SpecialOffersJSONNull?
}

// MARK: - Encode/decode helpers

class SpecialOffersJSONNull: Codable, Hashable {

    public static func == (lhs: SpecialOffersJSONNull, rhs: SpecialOffersJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
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
