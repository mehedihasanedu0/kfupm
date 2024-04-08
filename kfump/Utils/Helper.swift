//
//  Helper.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/3/24.
//

import Foundation
import SwiftUI



let FONT_LIGHT = "OpenSans-Light"
let FONT_MEDIUM = "OpenSans-Medium"
let FONT_REGULAR = "OpenSans-Regular"
let FONT_SEMIBOLD = "OpenSans-SemiBold"
let FONT_BOLD = "OpenSans-Bold"

var isRTL = LocalizationSystem.shared.getLanguage() == "ar"

func hexToColor(hex: String) -> Color {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    Scanner(string: hexSanitized).scanHexInt64(&rgb)

    let red = Double((rgb & 0xFF0000) >> 16) / 255.0
    let green = Double((rgb & 0x00FF00) >> 8) / 255.0
    let blue = Double(rgb & 0x0000FF) / 255.0

    return Color(red: red, green: green, blue: blue)
}


var sampleDataCategoryFilter : [FilterCourseItem] = [
    FilterCourseItem(id: 1, title: "Graphic Design", isSelect: false),
    FilterCourseItem(id: 2, title: "Web development", isSelect: false),
    FilterCourseItem(id: 3, title: "Amazone AWS Cloud Services", isSelect: false),
    FilterCourseItem(id: 4, title: "Google Ad Training", isSelect: false)
]

var sampleDataAvailableFilter : [FilterAvailableItem] = [
    FilterAvailableItem(id: 1, title: "Upcoming", isSelect: false),
    FilterAvailableItem(id: 2, title: "Available now", isSelect: false)
]


func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}
