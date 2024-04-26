//
//  RatingInfoModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation

struct RatingInfoModel: Identifiable {
    let id: Int?
    let ratingNumber: Int?
    let progress: CGFloat?
    // Sample data
    static let sampleData = [
        RatingInfoModel(id: 1,ratingNumber: 5, progress: 45.0),
        RatingInfoModel(id: 2,ratingNumber: 4, progress: 40.0),
        RatingInfoModel(id: 3,ratingNumber: 3, progress: 90.0),
        RatingInfoModel(id: 4,ratingNumber: 2, progress: 20.0),
        RatingInfoModel(id: 5,ratingNumber: 1, progress: 60.0)
    ]
}
