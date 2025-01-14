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

func hexToColor(hex: String,alpha: Double = 1.0) -> Color {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    let red = Double((rgb & 0xFF0000) >> 16) / 255.0
    let green = Double((rgb & 0x00FF00) >> 8) / 255.0
    let blue = Double(rgb & 0x0000FF) / 255.0
    
    return Color(red: red, green: green, blue: blue,opacity: alpha)
}


func hexToColor(hex: String,alpha: Double = 1.0) -> UIColor {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    let red = Double((rgb & 0xFF0000) >> 16) / 255.0
    let green = Double((rgb & 0x00FF00) >> 8) / 255.0
    let blue = Double(rgb & 0x0000FF) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
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


struct ProfileItem: Identifiable {
    var id: Int
    var nameAr: String
    var nameEn: String
    var image: String
}


var profileItemList : [ProfileItem] = [
    ProfileItem(id: 1, nameAr: "ملفي", nameEn: "My Profile", image: "ic_profile"),
    ProfileItem(id: 2, nameAr: "إعادة تعيين كلمة المرور", nameEn: "Reset Password", image: "ic_reset_password"),
    ProfileItem(id: 3, nameAr: "تاريخ الدفع", nameEn: "Payment History", image: "ic_payment_history"),
    ProfileItem(id: 4, nameAr: "لغة", nameEn: "Language", image: "ic_language"),
    ProfileItem(id: 5, nameAr: "تسجيل خروج", nameEn: "Log out", image: "ic_logout"),
    ProfileItem(id: 6, nameAr: "حساب مغلق", nameEn: "Close Account", image: "ic_close_account")
]



func encodeImageToBase64String(_ image: UIImage) -> String? {
    guard let imageData = image.pngData() else { return nil }
    return imageData.base64EncodedString()
}


func decodeBase64ToImage(_ base64: String) -> UIImage? {
    guard let imageData = Data(base64Encoded: base64) else { return nil }
    return UIImage(data: imageData)
}


func isValidEmail(_ email: String) -> Bool {
    
    guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
        return false
    }

    let matches = detector.matches(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count))
    
    for match in matches {
        if match.url?.scheme == "mailto" {
            return true
        }
    }
    
    return false
}

func getDate(_ item : String?) -> String {
    return DateUtils.convertDateString(item ?? "2024-04-29", fromFormat: "yyyy-MM-dd", toFormat: "MM/dd/yyyy")
}


func doubleFormat(_ value : Double) -> String {
    return  String(format: "%.2f", value)
}
