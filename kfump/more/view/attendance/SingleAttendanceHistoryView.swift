//
//  SingleAttendanceHistoryView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/5/24.
//

import SwiftUI

struct SingleAttendanceHistoryView: View {
    
    var singleAttendance : AttendanceData!
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Date:")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text(singleAttendance.date)
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,5)
            
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("Student name:")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text(singleAttendance.user.fullName ?? "")
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack {
                Text("Course name:")
                    .font(.custom(FONT_MEDIUM, size: 14))
                + Text(singleAttendance.course.title ?? "")
                    .font(.custom(FONT_REGULAR, size: 14))
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,2)
            
            HStack {
                Text(singleAttendance.isPresent ? "Present" : "Absent")
                    .font(.custom(FONT_MEDIUM, size: 14))
                    .padding(.vertical,6)
                    .padding(.horizontal,15)
                    .foregroundColor(singleAttendance.isPresent ? hexToColor(hex: "#007D40") : hexToColor(hex: "#DA2D21"))
                    .background(singleAttendance.isPresent ? hexToColor(hex: "#007D40",alpha: 0.2) : hexToColor(hex: "#DA2D21",alpha: 0.2))
                    .cornerRadius(15)
                
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    SingleAttendanceHistoryView()
}
