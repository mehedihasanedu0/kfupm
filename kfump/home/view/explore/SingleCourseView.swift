//
//  SingleCourseView.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct SingleCourseView: View {
    
    var course: Course
    
    var body: some View {
        
        ZStack {
            VStack {
                
//                Image("nature")
//                    .resizable()
//                    .frame(height: 130)
                
                WebImageView(imageUrl: course.coverImage ?? "")
//                    .aspectRatio(18/13, contentMode: .fill)
                    .frame(height: 130)
                
                HStack {
                    
                    WebImageView(imageUrl: course.createdBy?.image ?? "")
                        .frame(width: 30,height: 30)
                        .cornerRadius(15)
                    
                    
                    Text(course.createdBy?.fullName ?? "")
                        .font(.custom(FONT_REGULAR, size: 11))
                    
                    Spacer()
                    
                }
                .padding(.leading,10)
                .padding(.top,2)
                
                Text(course.title ?? "")
                    .font(.custom(FONT_SEMIBOLD, size: 11))
                    .padding(.top,1)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal,10)
                    .frame(height: 50)
                
                
                HStack {
                    
                    Text("View more")
                        .font(.custom(FONT_SEMIBOLD, size: 10))
                    
                    Image("ic_view_more")
                        .resizable()
                        .frame(width: 17,height: 15)
                        .cornerRadius(15)
                    
                    Spacer()
                    
                }
                .padding(.leading,10)
                .padding(.bottom,10)
                
                
            }
            .frame(height: 252)
            .background(hexToColor(hex: "#FFFFFF"))
            .cornerRadius(10)
            .padding(.horizontal,3)
            
        }
        .shadow(color: .gray, radius: 0.5, x: 0, y: 0.5)
    }
}

//#Preview {
//    SingleCourseView(course: nil)
//}
