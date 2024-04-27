//
//  Utils.swift
//  scai_ios
//
//  Created by S N Shekhar  Das on 10/11/23.
//


import Foundation
import SwiftUI

class Utils {
    
    
    
    static func formatDatePickerDateToSeverDate(dateString: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: dateString)
    }
    
    
    static func formatDate(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy"
        
        return outputFormatter.string(from: date)
    }
    
    static func formatTime(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a"
        
        return outputFormatter.string(from: date)
    }
    
    static func formatDateTo(from date: Date) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy"
        
        return outputFormatter.string(from: date)
    }
    
    static func formatDate(from dateString: String, dateFormat:String, format:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat ///yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        
        return outputFormatter.string(from: date)
    }
    
    
    func oddIndexedElements<T>(from array: [T]) -> [T] {
        var oddIndexedElements: [T] = []
        
        for index in stride(from: 1, to: array.count, by: 2) {
            if index < array.count {
                oddIndexedElements.append(array[index])
            }
        }
        
        return oddIndexedElements
    }
    
    
    func evenIndexedElements<T>(from array: [T]) -> [T] {
        var evenIndexedElements: [T] = []
        
        for index in stride(from: 0, to: array.count, by: 2) {
            if index < array.count {
                evenIndexedElements.append(array[index])
            }
        }
        
        return evenIndexedElements
    }
    
    func last30DaysDates() -> [String] {
        var dateStrings: [String] = []
        let calendar = Calendar.current

        for i in 0..<30 {
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
                
                let dateString = dateFormatter.string(from: date)
                dateStrings.append(dateString)
            }
        }
        
        return dateStrings.reversed() // Reversing to get dates in ascending order
    }
    
    func getTimeDifferenceInMinutes(dateString1: String, dateString2: String) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Adjust the date format based on your date strings

        // Convert date strings to Date objects
        guard let date1 = dateFormatter.date(from: dateString1),
              let date2 = dateFormatter.date(from: dateString2) else {
            return nil // Return nil if date conversion fails
        }

        // Calculate time interval in minutes
        let timeDifferenceInSeconds = date2.timeIntervalSince(date1)
        let timeDifferenceInMinutes = Double(timeDifferenceInSeconds / 60) // Convert seconds to minutes

        return abs(timeDifferenceInMinutes) // Return absolute value of difference
    }
    
    func getTimeDifferencefromCurrent(dateString1: String) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Adjust the date format based on your date strings

        // Convert date strings to Date objects
        let date2 = Date()
        guard let date1 = dateFormatter.date(from: dateString1)
               else {
            return nil // Return nil if date conversion fails
        }

        // Calculate time interval in minutes
        let timeDifferenceInSeconds = date2.timeIntervalSince(date1)
        let timeDifferenceInMinutes = Double(timeDifferenceInSeconds / 60) // Convert seconds to minutes

        return abs(timeDifferenceInMinutes) // Return absolute value of difference
    }
    
    static func cheackInAtDateFormat(_ inputDateString : String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "d MMM, yyyy 'at' h:mm a"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX") // Important for parsing AM/PM correctly
        
        if let date = inputDateFormatter.date(from: inputDateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
            outputDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            let outputDateString = outputDateFormatter.string(from: date)
            print(outputDateString)
            return outputDateString
            
        } else {
            print("Invalid date format")
            return ""
        }
    }
    
//    static func cheackInAtDateFormat(_ inputDateString : String) -> (datePart: String, timePart: String) {
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "dd MMM, yyyy 'at' hh:mm a"
//        inputFormatter.locale = Locale(identifier: "en_US_POSIX") 
//
//        guard let date = inputFormatter.date(from: inputDateString) else {
//            return ("Invalid Date", "Invalid Time")
//        }
//        
//        let outputDateFormatter = DateFormatter()
//        outputDateFormatter.dateFormat = "yyyy-MM-dd'T'" // Date format
//        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
//
//        let outputTimeFormatter = DateFormatter()
//        outputTimeFormatter.dateFormat = "HH:mm" // 24-hour time format
//        outputTimeFormatter.locale = Locale(identifier: "en_US_POSIX")
//
//        let datePart = outputDateFormatter.string(from: date)
//        let timePart = outputTimeFormatter.string(from: date)
//        
//        return (datePart, timePart)
//    }
    

    
    static func bookingEndDateTimeFormat(_ datetimeStr : String) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        // Parse the string into a Date object
        if let date = formatter.date(from: datetimeStr) {
            // Add 1 hour to the date
            if let newDate = Calendar.current.date(byAdding: .hour, value: 1, to: date) {
                // Formatting the new date to string (optional)
                let newDateString = formatter.string(from: newDate)
                return newDateString
            } else {
                print("Error: Could not add 1 hour to the date.")
                return ""
            }
        } else {
            print("Error: The date string could not be parsed.")
            return ""
        }
        
    }
    
    static func convertDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // ISO 8601 format
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = inputFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "M/d/yyyy" // Desired format
        outputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return outputFormatter.string(from: date)
    }
    
    
    static func convertDateOnly(_ startDateString: String,_ endDateString: String) -> String {
        let inputFormatter = DateFormatter()
        print("dateString \(startDateString)")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // ISO 8601 format
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = inputFormatter.date(from: startDateString) else {
            return "Invalid Date"
        }
        
        // Add 3 hours to the date
        let adjustedDate = date.addingTimeInterval(3 * 60 * 60)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a" // Desired format
        outputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return outputFormatter.string(from: adjustedDate) + " - \(convertDateAfterAddOneHour(endDateString))"
    }
    
    
    static func convertDateAfterAddOneHour(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // ISO 8601 format
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = inputFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        // Add 1 hour to the date
        let modifiedDate = Calendar.current.date(byAdding: .hour, value: 3, to: date) ?? date
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a" // Desired format
        outputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return outputFormatter.string(from: modifiedDate)
    }
    
    
    static func convertVisitorHistoryServerToUIDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // ISO 8601 format with timezone
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // Use POSIX to avoid user's locale issues
        guard let date = inputFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMM, yyyy 'at' h:mm a" // Desired format
        outputFormatter.locale = Locale(identifier: "en_US") // Set locale to English United States
        return outputFormatter.string(from: date)
    }      
    
    static func chatTimeformatDateString(_ dateString: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ" // ISO 8601 format with timezone
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // Use POSIX to avoid user's locale issues
        guard let date = inputFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, h:mm a" // Desired format
        outputFormatter.locale = Locale(identifier: "en_US") // Set locale to English United States
        return outputFormatter.string(from: date)

    }
    
    static func notificationDateFormat(_ dateString: String)  -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMM, H:mm"
            return outputFormatter.string(from: date)
        } else {
            print("Invalid date format")
            return ""
        }
        
    }
    
    
    static func getHourRatio(_ hourString: String)  -> Double {
//        let time = "3.95"
        let logHour = 8 - (Double(hourString) ?? 0.0)
        print("logHour \(logHour)")
        return Double(getHourLeftRatio("\(logHour)")) ?? 0.0
    }
    
    static func getHourLeftRatio(_ hourString: String)  -> String {
        
        
//        let time = "3.95"
        // Split the string using the dot as a delimiter
        let components = hourString.split(separator: ".")
        
        // Access the components
        if let firstComponent = components.first, let secondComponent = components.last {
            let part1 = String(firstComponent)
            let part2 = Double(secondComponent) ?? 0.0
            
            print("Part 1: \(part1)")
            print("Part 2: \(part2)")
            
            if let part2 = Float(String(secondComponent)) {
                var dividedPart2 = part2 / 100
                dividedPart2 = dividedPart2 * 60
                print("Part 1: \(part1)")
                print("Divided Part 2: \(dividedPart2)")
                if Int(dividedPart2) == 60 {
                    return "\((Int(part1) ?? 0) + 1).\(0)"
                } else {
                    return "\(part1).\(Int(dividedPart2))"
                }
                
                
            } else {
                print("Invalid second component")
            }
            
        } else {
            print("Invalid input string")
        }
        
        return ""
        
    }
    
    
    // MARK: - Refresh Token
    static func isJWTTokenExpire() -> Bool {
        
        @AppStorage(Keys.TOKEN_D.rawValue) var jwtToken: String?
        print("jwtToken \(jwtToken ?? "")")

        var payload64 = jwtToken!.components(separatedBy: ".")[1]

        while payload64.count % 4 != 0 {
            payload64 += "="
        }

        print("base64 encoded payload: \(payload64)")
        let payloadData = Data(base64Encoded: payload64,
                               options:.ignoreUnknownCharacters)!
        let payload = String(data: payloadData, encoding: .utf8)!
        print(payload)
        
        let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
        let exp = json["exp"] as! Int
        let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
        let isValid = expDate.compare(Date()) == .orderedDescending
        
        print("json \(json)")
        print("exp \(exp)")
        print("isValid \(isValid)")
        
        return !isValid
        
    }
    
    
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
    
}



