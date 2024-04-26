//
//  SyllabusModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation

struct SyllabusModel: Identifiable {
    
    let id: Int?
    let weekNo: Int?
    let title: String?
    let details: String?
    let syllabus: String?
    let attendanceMessage: String?
    // Sample data
    static let sampleData = [
        SyllabusModel(id: 1, weekNo: 1, title: "Thinking like a UX designer", details: "In this module, you will learn what it means to be happy and why pursuing happiness is not a pointless endeavor. Dr. Santos addresses how our minds lie to us and how the science shows that our misconceptions about money, grades, and social media are holding us back from implementing the techniques studied in positive psychology.", syllabus: "2 offline lecture, 1 assignment, 1 quiz", attendanceMessage: "2 classes to attend"),
        SyllabusModel(id: 2, weekNo: 2, title: "Thinking like a UX designer", details: "In this module, you will learn what it means to be happy and why pursuing happiness is not a pointless endeavor. Dr. Santos addresses how our minds lie to us and how the science shows that our misconceptions about money, grades, and social media are holding us back from implementing the techniques studied in positive psychology.", syllabus: "2 offline lecture, 1 assignment, 1 quiz", attendanceMessage: "2 classes to attend"),
        SyllabusModel(id: 3, weekNo: 3, title: "Thinking like a UX designer", details: "In this module, you will learn what it means to be happy and why pursuing happiness is not a pointless endeavor. Dr. Santos addresses how our minds lie to us and how the science shows that our misconceptions about money, grades, and social media are holding us back from implementing the techniques studied in positive psychology.", syllabus: "2 offline lecture, 1 assignment, 1 quiz", attendanceMessage: "2 classes to attend"),
        SyllabusModel(id: 4, weekNo: 4, title: "Thinking like a UX designer", details: "In this module, you will learn what it means to be happy and why pursuing happiness is not a pointless endeavor. Dr. Santos addresses how our minds lie to us and how the science shows that our misconceptions about money, grades, and social media are holding us back from implementing the techniques studied in positive psychology.", syllabus: "2 offline lecture, 1 assignment, 1 quiz", attendanceMessage: "2 classes to attend"),
    ]
}
