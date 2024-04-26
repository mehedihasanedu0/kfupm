//
//  CourseReviewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation


struct CourseReviewModel: Identifiable {
    
    let id: Int?
    let image: String?
    let name: String?
    let date: String?
    let review: String?
    let rating: Double?
    
    // Sample data
    static let sampleData = [
        CourseReviewModel(id: 1, image: "", name: "Mehedi", date: "Feb 12, 2022", review: "Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.", rating: 4.6),
        CourseReviewModel(id: 2, image: "", name: "Mehedi", date: "Feb 12, 2022", review: "Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.", rating: 4.6),
        CourseReviewModel(id: 3, image: "", name: "Mehedi", date: "Feb 12, 2022", review: "Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.", rating: 4.6),
        CourseReviewModel(id: 4, image: "", name: "Mehedi", date: "Feb 12, 2022", review: "Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.", rating: 4.6),
        CourseReviewModel(id: 5, image: "", name: "Mehedi", date: "Feb 12, 2022", review: "Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.", rating: 4.6),
        CourseReviewModel(id: 6, image: "", name: "Mehedi", date: "Feb 12, 2022", review: "Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.", rating: 4.6)
    ]
}
