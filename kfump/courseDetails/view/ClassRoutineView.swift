//
//  ClassRoutineView.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/4/24.
//

import SwiftUI

struct ClassRoutineView: View {
    

    
    var body: some View {
        
        VStack {
            ForEach(ClassRoutingModel.sampleData) { item in
                
                VStack {
                    HStack {
                        
                        Text(item.daysOfWeek)
                            .font(.headline)
                            .font(.custom(FONT_REGULAR, size: 12))
                        
                        Spacer()
                        
                        HStack {
                            Image("course_calendar")
                                .resizable()
                                .frame(width: 12,height: 12)
                            Text(item.date)
                                .font(.custom(FONT_LIGHT, size: 12))
                        }
                        HStack {
                            Image("course_clock")
                                .resizable()
                                .frame(width: 12,height: 12)
                            Text(item.time)
                                .font(.custom(FONT_LIGHT, size: 12))
                        }
                    }
                    
                    .padding(.vertical,15)
                    .padding(.horizontal,10)
                    .background(hexToColor(hex: (item.id % 2 == 1) ? "#FFFFFF" : "#E5E5D9"))
                    
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
}
//
//#Preview {
//    ClassRoutineView()
//}
