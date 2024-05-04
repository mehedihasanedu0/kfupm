//
//  CourseEnrolledModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 1/5/24.
//

import Foundation


struct CourseEnrolled: Codable {
    let success: Bool
    let message: String
    let timestamp: String
    let data: CourseEnrolledData
    
    enum CodingKeys: String, CodingKey {
        case success, message, timestamp, data
    }
}


struct CourseEnrolledData: Codable {
    let id: Int
    let enrolledType: String
    let status: String
    let paymentMethod: String
    let paymentStatus: String
    let serviceCost: String
    let platformFee: String?
    let commission: String?
    let vatPercent: String
    let totalAmount: String
    let createdAt: String
    let updatedAt: String
    let course: Int
    let courseInfo: Course
    let user: Int
    
    enum CodingKeys: String, CodingKey {
        case id, status,commission,course, user
        case enrolledType = "enrolled_type"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case serviceCost = "service_cost"
        case platformFee = "platform_fee"
        case vatPercent = "vat_percent"
        case totalAmount = "total_amount"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case courseInfo = "course_info"
    }
}
