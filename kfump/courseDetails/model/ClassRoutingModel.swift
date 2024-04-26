//
//  ClassRoutingModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/4/24.
//

import Foundation
let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
let date = "12/03/2023"
let time = "10:30 - 11:30"

struct ClassRoutingModel: Identifiable {
    let id: Int
    let daysOfWeek: String
    let date: String
    let time: String

    // Sample data
    static let sampleData = [
        ClassRoutingModel(id: 1, daysOfWeek: "Sunday",date: "12/03/2023", time: "10:30 - 11:30"),
        ClassRoutingModel(id: 2, daysOfWeek: "Monday",date: "12/03/2023", time: "10:30 - 11:30"),
        ClassRoutingModel(id: 3, daysOfWeek: "Tuesday",date: "12/03/2023", time: "10:30 - 11:30"),
        ClassRoutingModel(id: 4, daysOfWeek: "Wednesday",date: "12/03/2023", time: "10:30 - 11:30"),
        ClassRoutingModel(id: 5, daysOfWeek: "Thursday",date: "12/03/2023", time: "10:30 - 11:30"),
        ClassRoutingModel(id: 6, daysOfWeek: "Friday",date: "12/03/2023", time: "10:30 - 11:30"),
        ClassRoutingModel(id: 7, daysOfWeek: "Saturday",date: "12/03/2023", time: "10:30 - 11:30")
    
    ]
}
