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
            ForEach(Array(WeakDay.WeakDayData.enumerated()), id: \.1.id) { index, item in
                
                VStack {
                    HStack {
                        
                        Text(item.name ?? "")
                            .font(.headline)
                            .font(.custom(FONT_REGULAR, size: 12))
                        
                        Spacer()
                        
//                        HStack {
//                            Image("course_calendar")
//                                .resizable()
//                                .frame(width: 12,height: 12)
//                            Text(getDate(item.date ?? ""))
//                                .font(.custom(FONT_LIGHT, size: 12))
//                        }
                        HStack {
                            Image("course_clock")
                                .resizable()
                                .frame(width: 12,height: 12)
                            Text(index > (singleClassRoutine.count - 1) ? "No class available" : getTime(singleClassRoutine[index]))
                                .font(.custom(FONT_LIGHT, size: 12))
                            Spacer()
                        }
                        .frame(width: 170)
                        
                        
                    }
                    
                    .padding(.vertical,15)
                    .padding(.horizontal,10)
                    .background((index % 2 == 1) ? hexToColor(hex: "#E5E5D9",alpha: 0.4) : hexToColor(hex: "#FFFFFF"))
                    
                    //                    Divider()
                    //                        .frame(height: 1)
                }
                
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(hexToColor(hex: "#E5E5D9"), lineWidth: 1)
        }
        
        
        
        
    }
    
    
    func getTime(_ item : ClassRoutineInfo) -> String {
        let startTime = DateUtils.convertTimeString(item.startTime ?? "10:00:00", fromFormat: "HH:mm:ss", toFormat: "HH:mm")
        let endTime = DateUtils.convertTimeString(item.endTime ?? "10:00:00", fromFormat: "HH:mm:ss", toFormat: "HH:mm")
        return item.startTime == nil ? "No class available" : "\(startTime)-\(endTime)"
    }
    
}
//
//#Preview {
//    ClassRoutineView()
//}
