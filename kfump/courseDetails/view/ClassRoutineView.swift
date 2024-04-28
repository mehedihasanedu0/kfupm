//
//  ClassRoutineView.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/4/24.
//

import SwiftUI

struct ClassRoutineView: View {
    
    let singleClassRoutine : [ClassRoutineInfo]!
    
    var body: some View {
        
        VStack {
            ForEach(singleClassRoutine,id: \.id) { item in
                
                VStack {
                    HStack {
                        
                        Text(item.day ?? "")
                            .font(.headline)
                            .font(.custom(FONT_REGULAR, size: 12))
                        
                        Spacer()
                        
                        HStack {
                            Image("course_calendar")
                                .resizable()
                                .frame(width: 12,height: 12)
                            Text(getDate(item))
                                .font(.custom(FONT_LIGHT, size: 12))
                        }
                        HStack {
                            Image("course_clock")
                                .resizable()
                                .frame(width: 12,height: 12)
                            Text(getTime(item))
                                .font(.custom(FONT_LIGHT, size: 12))
                        }
                    }
                    
                    .padding(.vertical,15)
                    .padding(.horizontal,10)
                    .background(hexToColor(hex: ((item.id ?? 0)  % 2 == 1) ? "#FFFFFF" : "#E5E5D9"))
                    
                    //                    Divider()
                    //                        .frame(height: 1)
                }
                
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 0.3)
        }
        
        
        
        
    }
    
    func getDate(_ item : ClassRoutineInfo) -> String {
        return DateUtils.convertDateString(item.date ?? "2024-04-29", fromFormat: "yyyy-MM-dd", toFormat: "MM/dd/yyyy")
    }
    
    func getTime(_ item : ClassRoutineInfo) -> String {
        let startTime = DateUtils.convertTimeString(item.startTime ?? "10:00:00", fromFormat: "HH:mm:ss", toFormat: "HH:mm")
        let endTime = DateUtils.convertTimeString(item.endTime ?? "10:00:00", fromFormat: "HH:mm:ss", toFormat: "HH:mm")
        return "\(startTime)-\(endTime)"
    }
    
}
//
//#Preview {
//    ClassRoutineView()
//}
