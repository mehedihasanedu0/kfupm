//
//  SingleEnrolledCourseView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct SingleEnrolledCourseView: View {
    
    var course: Course
    let courseStatus : String!
    
    var body: some View {
        
        ZStack {
            VStack {
                
                
                WebImageView(imageUrl: course.coverImage ?? "")
//                    .aspectRatio(18/13, contentMode: .fill)
                    .frame(height: 130)
                    .onAppear{
                        print("Single Course \(course)")
                    }
                
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
                    
//                    Text(course.status ?? "")
                    Text(courseStatus)
                        .font(.custom(FONT_SEMIBOLD, size: 10))
                        .foregroundColor(hexToColor(hex: "#D0B756"))
                    
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
//    SingleEnrolledCourseView(course: Course(id: 1, createdBy: nil, createdAt: "", updatedAt: "", coverImage: "nature", title: "Python for Beginners - Learn Programming from scratch", subtitle: "", description: "", status: "", registrationStatus: "", slug: "", fee: 0.0, groupEnrolledDiscountFee: 0.0, qrCode: "", category: nil, availability: 0, facilitator: nil))
//}
