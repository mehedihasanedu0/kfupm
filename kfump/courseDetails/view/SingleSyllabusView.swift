//
//  SingleSyllabusView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct SingleSyllabusView: View {
    
    var body: some View {
        VStack {
            HStack {
                
                VStack {
                    VStack {
                        Text("1")
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
                    
                    Text("Thinking like a UX designer")
                        .font(.custom(FONT_MEDIUM, size: 15)) 
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    
                    Text("In this module, you will learn what it means to be happy and why pursuing happiness is not a pointless endeavor. Dr. Santos addresses how our minds lie to us and how the science shows that our misconceptions about money, grades, and social media are holding us back from implementing the techniques studied in positive psychology.")
                        .font(.custom(FONT_LIGHT, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical,5)
                    
                    
                    HStack {
                        
                        Image("course_syllabus")
                            .resizable()
                            .frame(width: 20,height: 20)
                        
                        Text("2 offline lecture, 1 assignment, 1 quiz")
                            .font(.custom(FONT_MEDIUM, size: 13))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        
                        Spacer()
                    }
                                        
                    
                    HStack {
                        
                        Image("course_clock_green")
                            .resizable()
                            .frame(width: 20,height: 20)
                        
                        Text("2 classes to attend")
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
    SingleSyllabusView()
}
