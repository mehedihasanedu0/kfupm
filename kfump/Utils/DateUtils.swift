//
//  DateUtils.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/4/24.
//

import Foundation


import Foundation
import SwiftUI

class DateUtils {
    
    
    static func getIssueDate(isoDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Use POSIX to avoid unexpected behavior
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Specify the timezone if needed
        
        if let date = dateFormatter.date(from: isoDate) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = dateFormatter.string(from: date)
            print(formattedDate) // This will print "27/04/2024"
            return formattedDate
        }
        
        return ""
    }
    
    
    static func convertDateString(_ dateString: String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
    
    
    static func convertTimeString(_ timeString: String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // This prevents unexpected behaviors due to locale differences

        if let time = dateFormatter.date(from: timeString) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: time)
        } else {
            return "Invalid time"
        }
    }
    
        
    static func paymentHistoryDateFormat(_ dateString: String) -> String {
        let sparateDateString = addPlus6Hour(dateString).components(separatedBy: "T")[0]
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatterGet.date(from: sparateDateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            print("Failed to parse date")
        }
        return ""
    }
    
    
    
    static func addPlus6Hour(_ dateString: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoDateFormatter.date(from: dateString) else {
            print("Failed to parse date")
            return ""
        }
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .hour, value: 6, to: date) {
            return isoDateFormatter.string(from: newDate)
        } else {
            print("Failed to add 6 hours to the date")
        }
        return ""
    }  
    
    static func chatLastSeenDate(_ dateString: String) -> String {
        
        let sparateDateString = addPlus6Hour(dateString).components(separatedBy: "T")[0]
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatterGet.date(from: sparateDateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d"
            return dateFormatter.string(from: date)
        } else {
            print("Failed to parse date")
        }
        return ""
    }
    
}
