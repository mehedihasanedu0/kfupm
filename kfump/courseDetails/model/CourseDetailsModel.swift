//
//  CourseDetailsModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/4/24.
//

import Foundation


struct CourseDetailsResponseModel: Codable {
    let success: Bool
    let message: String
    let timestamp: String
    let data: CourseData
}

struct CourseData: Codable{
    var id: Int?
    var createdBy: CreatedBy?
    var syllabusInfo: [SyllabusInfo]?
    var classRoutineInfo: [ClassRoutineInfo]?
    var rating: [Rating]?
    var createdAt: String?
    var updatedAt: String?
    var coverImage: String?
    var title: String?
    var subtitle: String?
    var description: String?
    var status: String?
    var registrationStatus: String?
    var slug: String?
    var fee: Double?
    var groupEnrolledDiscountFee: Double?
    var qrCode: String?
    var category: Int?
    var availability: Int?
//    var facilitator: [Facilitator]
    var ratingPercentage: [String: Double]?
    var ratingAverage: Double?
    var enrollmentStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case id,rating, createdAt = "created_at", updatedAt = "updated_at", title, subtitle, description, status, registrationStatus, slug, fee, groupEnrolledDiscountFee, qrCode, category, availability, ratingAverage
        case coverImage = "cover_image"
        case syllabusInfo = "syllabus_info"
        case classRoutineInfo = "class_routine_info"
        case ratingPercentage = "rating_percentage"
        case createdBy = "created_by"
        case enrollmentStatus = "enrollment_status"
    }
}

struct CreatedBy: Codable {
    var id: Int?
    var fullName: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var image: String?
    var designation: String?
    var description: String?
    var totalCourse: Int?
    var ratingAverage: Double?
    var totalRating: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, fullName = "full_name", email, firstName = "first_name", lastName = "last_name", image, designation, description, totalCourse = "total_course", ratingAverage = "rating_average", totalRating = "total_rating"
    }
}

struct SyllabusInfo: Codable,Identifiable {
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var week: String?
    var classToAttend: String?
    var syllabusTitle: String?
    var noOfLectures: String?
    var noOfQuiz: String?
    var noOfAssignment: String?
    var description: String?
    var course: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt = "created_at", updatedAt = "updated_at", week, classToAttend = "class_to_attend", syllabusTitle = "syllabus_title", noOfLectures = "no_of_lectures", noOfQuiz = "no_of_quiz", noOfAssignment = "no_of_assignment", description, course
    }
}

struct ClassRoutineInfo: Codable,Identifiable {
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var day: String?
    var date: String?
    var startTime: String?
    var endTime: String?
    var course: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt = "created_at", updatedAt = "updated_at", day, date, startTime = "start_time", endTime = "end_time", course
    }
}

struct Rating: Codable,Identifiable {
    var id: Int?
    var user: User?
    var createdAt: String?
    var updatedAt: String?
    var rate: Double?
    var description: String?
    var status: String?
    var course: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, user, createdAt = "created_at", updatedAt = "updated_at", rate, description, status, course
    }
}

struct User: Codable {
    var id: Int?
    var username: String?
    var email: String?
    var firstName: String?
    var fullName: String?
    var lastName: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, username, email, firstName = "first_name", lastName = "last_name", image
        case fullName = "full_name"
    }
}
