//
//  CourseListResponse.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/4/24.
//

import Foundation

// Main response model
struct CourseListResponseModel: Codable {
    let message: String
    let timestamp: String
    let items: [Course]
    let metadata: Metadata
}

struct Course: Identifiable, Codable {
    let id: Int?
    let createdBy: Creator?
    let createdAt, updatedAt: String?
    let coverImage, title, subtitle, description: String?
    let status, registrationStatus, slug: String?
    let fee, groupEnrolledDiscountFee: Double?
    let qrCode: String?
    let category: Int?
    let availability: Int?
    let facilitator: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case coverImage = "cover_image"
        case title, subtitle, description, status
        case registrationStatus = "registration_status"
        case slug, fee
        case groupEnrolledDiscountFee = "group_enrolled_discount_fee"
        case qrCode = "qr_code"
        case category, availability, facilitator
    }
    
    
    static let dummyData = [
    
        Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 2, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 3, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 4, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 5, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 6, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 7, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 8, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 9, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 10, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 11, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
    
    ]
}


struct Creator: Codable {
    let id: Int?
    let fullName, email: String?
    let firstName, lastName: String?
    let image, designation, description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case fullName = "full_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case image, designation, description
    }
}


struct Metadata: Codable {
    let pagination: Pagination?
}

struct Pagination: Codable {
    let offset, limit, previousOffset, nextOffset: Int?
    let currentPage, pageCount, totalCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case offset, limit
        case previousOffset = "previous_offset"
        case nextOffset = "next_offset"
        case currentPage = "current_page"
        case pageCount = "page_count"
        case totalCount = "total_count"
    }
}
