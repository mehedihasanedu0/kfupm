//
//  ExploreItem.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/3/24.
//

import Foundation

struct MoreItems : Identifiable {
    let id: Int
    let icone: String
    let nameEn: String
    let nameAr: String
    
    // Sample data
    static let sampleData = [
        MoreItems(id: 1, icone: "more_enroll_course", nameEn: "Enrolled Courses", nameAr: "الدورات المسجلة"),
        MoreItems(id: 2, icone: "more_ongoing_course", nameEn: "Ongoing Course", nameAr: "دورة مستمرة"),
        MoreItems(id: 3, icone: "more_attendance_history", nameEn: "Attendance History", nameAr: "تاريخ الحضور"),
        MoreItems(id: 4, icone: "more_course_history", nameEn: "Course History", nameAr: "تاريخ الدورة"),
        MoreItems(id: 5, icone: "more_message", nameEn: "Messages", nameAr: "رسائل"),
        MoreItems(id: 6, icone: "more_notification", nameEn: "Notification", nameAr: "إشعار"),
        MoreItems(id: 7, icone: "more_report_issue", nameEn: "Report an Issue", nameAr: "بلغ عن خطأ"),
        MoreItems(id: 8, icone: "more_contac_us", nameEn: "Contact Us", nameAr: "اتصل بنا")
    ]
}
