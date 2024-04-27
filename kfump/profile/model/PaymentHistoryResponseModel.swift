//
//  PaymentHistoryModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation

struct PaymentHistoryResponseModel: Decodable,Identifiable {
    
//    let success: Bool
//    let message: String
//    let timestamp: String
//    let data: [PaymentHistory]
//    
//    struct PaymentHistory: Decodable {
//        let id: Int
//        let createdAt: String
//        let updatedAt: String
//        let totalAmount: Int
//        let enrollmentType: String
//        let status: String
//        let course: Course
//        let courseEnroll: CourseEnroll
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case createdAt = "created_at"
//            case updatedAt = "updated_at"
//            case totalAmount = "total_amount"
//            case enrollmentType = "enrollment_type"
//            case status
//            case course
//            case courseEnroll = "course_enroll"
//        }
//    }
//
//    struct Course: Decodable {
//        let id: Int
//        let createdAt: String
//        let updatedAt: String
//        let coverImage: String?
//        let title: String
//        let subtitle: String
//        let description: String
//        let status: String
//        let registrationStatus: String
//        let slug: String
//        let fee: Int
//        let groupEnrolledDiscountFee: Int
//        let qrCode: String
//        let category: Int
//        let availability: Int
//        let createdBy: Int
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case createdAt = "created_at"
//            case updatedAt = "updated_at"
//            case coverImage = "cover_image"
//            case title
//            case subtitle
//            case description
//            case status
//            case registrationStatus = "registration_status"
//            case slug
//            case fee
//            case groupEnrolledDiscountFee = "group_enrolled_discount_fee"
//            case qrCode = "qr_code"
//            case category
//            case availability
//            case createdBy = "created_by"
//        }
//    }
//
//    // Course enrollment details
//    struct CourseEnroll: Decodable {
//        let id: Int
//        let enrolledType: String
//        let status: String
//        let paymentMethod: String
//        let paymentStatus: String?
//        let serviceCost: String
//        let platformFee: String?
//        let commission: String?
//        let vatPercent: String
//        let totalAmount: String
//        let createdAt: String
//        let updatedAt: String
//        let course: Int
//        let user: Int
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case enrolledType = "enrolled_type"
//            case status
//            case paymentMethod = "payment_method"
//            case paymentStatus = "payment_status"
//            case serviceCost = "service_cost"
//            case platformFee = "platform_fee"
//            case commission
//            case vatPercent = "vat_percent"
//            case totalAmount = "total_amount"
//            case createdAt = "created_at"
//            case updatedAt = "updated_at"
//            case course
//            case user
//        }
//    }
    
    let id: Int?
    let date: String?
    let courseName: String?
    let amount: String?
    let enrolmentType: String?
    
    // Sample data
    static let sampleData = [
        PaymentHistoryResponseModel(id: 1, date: " 07/02/2023", courseName: "Fundamental of UX design", amount: "SA 999", enrolmentType: "Personal"),
        PaymentHistoryResponseModel(id: 2, date: " 07/02/2023", courseName: "Fundamental of UX design", amount: "SA 999", enrolmentType: "Personal"),
        PaymentHistoryResponseModel(id: 3, date: " 07/02/2023", courseName: "Fundamental of UX design", amount: "SA 999", enrolmentType: "Personal"),
        PaymentHistoryResponseModel(id: 4, date: " 07/02/2023", courseName: "Fundamental of UX design", amount: "SA 999", enrolmentType: "Personal"),
        PaymentHistoryResponseModel(id: 5, date: " 07/02/2023", courseName: "Fundamental of UX design", amount: "SA 999", enrolmentType: "Personal"),
        PaymentHistoryResponseModel(id: 6, date: " 07/02/2023", courseName: "Fundamental of UX design", amount: "SA 999", enrolmentType: "Personal"),
    ]
}

