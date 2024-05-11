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
    
        Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
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
    
    static let ongoingSampleData = [
        Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "ONGOING", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 2, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "ONGOING", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
    ]    
    
    static let courseHistorySampleData = [
        Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "COMPLETED", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
        Course(id: 2, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "", title: "", subtitle: "", description: "", status: "COMPLETED", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil),
    ]    
    
    static let enrolledSampleData = [
        SingleEnrolledItem(id: 1, course: Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "ENROLLED", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil), enrolledType: "", status: "", paymentMethod: "", paymentStatus: "", serviceCost: "", platformFee: "", commission: "", vatPercent: "", totalAmount: "", user: 1),
        SingleEnrolledItem(id: 2, course: Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "ENROLLED", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil), enrolledType: "", status: "", paymentMethod: "", paymentStatus: "", serviceCost: "", platformFee: "", commission: "", vatPercent: "", totalAmount: "", user: 1),
        SingleEnrolledItem(id: 3, course: Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "ENROLLED", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil), enrolledType: "", status: "", paymentMethod: "", paymentStatus: "", serviceCost: "", platformFee: "", commission: "", vatPercent: "", totalAmount: "", user: 1),
        SingleEnrolledItem(id: 4, course: Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "ENROLLED", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil), enrolledType: "", status: "", paymentMethod: "", paymentStatus: "", serviceCost: "", platformFee: "", commission: "", vatPercent: "", totalAmount: "", user: 1),
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


// Enrolled Course model
struct EnrolledCourseResponseModel: Codable {
    let message: String
    let timestamp: String
    let data: [SingleEnrolledItem]
    let metadata: Metadata?
}

struct SingleEnrolledItem: Codable {
    
    let id: Int?
    let course: Course?
    let enrolledType: String?
    let status: String?
    let paymentMethod: String?
    let paymentStatus: String?
    let serviceCost: String?
    let platformFee: String?
    let commission: String?
    let vatPercent: String?
    let totalAmount: String?
    let user: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case course
        case enrolledType = "enrolled_type"
        case status = "status"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case serviceCost = "service_cost"
        case platformFee = "platform_fee"
        case commission = "commission"
        case vatPercent = "vat_percent"
        case totalAmount = "total_amount"
        case user = "user"
    }
    
}



