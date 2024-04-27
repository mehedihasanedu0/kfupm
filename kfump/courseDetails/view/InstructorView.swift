//
//  InstructorView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import Foundation

import SwiftUI

struct InstructorView: View {
    
    
    var body: some View {
        VStack {
            
            
            HStack {
                Text("Instructor")
                    .font(.custom(FONT_BOLD, size: 16))
                Spacer()
            }
            .padding(.top,30)
            .padding(.bottom)
            
            HStack {
                // Profile image
                Image("nature")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                
                // Profile details
                VStack(alignment: .leading, spacing: 4) {
                    // Name and tag
                    HStack {
                        Text("John Doe")
                            .font(.custom(FONT_BOLD, size: 14))
                            .foregroundColor(.gray)
                        
                        
                        
                        Text("Instructor")
                            .font(.custom(FONT_MEDIUM, size: 10))
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical,5)
                            .padding(.horizontal,10)
                            .background(hexToColor(hex: "#D0B756"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.leading)
                        
                        
                        Spacer()
                    }
                    
                    // Rating
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(hexToColor(hex: "#D0B756"))
                        Text("4.77/5 ")
                            .font(.custom(FONT_MEDIUM, size: 12))
                            .foregroundColor(hexToColor(hex: "#D0B756"))
                        
                        Text("(9 Ratings)")
                            .font(.custom(FONT_MEDIUM, size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    // Courses
                    HStack {
                        Image(systemName: "book.closed")
                            .foregroundColor(.gray)
                        Text("2 Courses")
                            .font(.custom(FONT_MEDIUM, size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading,15)
            }
            .padding()
            .background(hexToColor(hex: "#F9F9F7"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .shadow(color: .gray, radius: 5, x: 0, y: 2)
        }
    }
}

//
//#Preview {
//    InstructorView()
//}
