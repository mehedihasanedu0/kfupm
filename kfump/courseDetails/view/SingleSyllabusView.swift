//
//  SingleSyllabusView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct SingleSyllabusView: View {
    
    let singleSyllabus : SyllabusModel?
    
    var body: some View {
        VStack {
            HStack {
                
                VStack {
                    VStack {
                        Text("\(singleSyllabus?.weekNo ?? 0)")
                            .font(.custom(FONT_BOLD, size: 18))
                        Text("WEEK")
                            .font(.custom(FONT_LIGHT, size: 10))
                        
                    }
                    .frame(width: 48,height: 48)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray, lineWidth: 0.3)
                    }
                    
                    Spacer()
                }
                
                
                VStack {
                    
                    Text(singleSyllabus?.title ?? "")
                        .font(.custom(FONT_MEDIUM, size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    
                    Text(singleSyllabus?.details ?? "")
                        .font(.custom(FONT_LIGHT, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical,5)
                    
                    
                    HStack {
                        
                        Image("course_syllabus")
                            .resizable()
                            .frame(width: 20,height: 20)
                        
                        Text(singleSyllabus?.syllabus ?? "")
                            .font(.custom(FONT_MEDIUM, size: 13))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        
                        Spacer()
                    }
                                        
                    
                    HStack {
                        
                        Image("course_clock_green")
                            .resizable()
                            .frame(width: 20,height: 20)
                        
                        Text(singleSyllabus?.attendanceMessage ?? "")
                            .font(.custom(FONT_MEDIUM, size: 13))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        
                        Spacer()
                    }
                    
                    
                    Spacer()
                }
                
                .offset(y: 20)
                
                
            }
        }
    }
}

#Preview {
    SingleSyllabusView(singleSyllabus: nil)
}
