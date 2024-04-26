//
//  SingleReviewView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct SingleReviewView: View {
    
    var singleReview : CourseReviewModel?
    
    var body: some View {
        VStack {
            
            HStack {
                Image("nature")
                    .resizable()
                    .frame(width: 48,height: 48)
                    .cornerRadius(8)
                
                
                VStack {
                    Text(singleReview?.name ?? "")
                        .font(.custom(FONT_MEDIUM, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(singleReview?.date ?? "")
                        .font(.custom(FONT_MEDIUM, size: 12))
                        .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading,6)
            }
            
            
            Text(singleReview?.review ?? "")
                .font(.custom(FONT_MEDIUM, size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(hexToColor(hex: "#7C7C7C"))
                .padding(.vertical,10)
            
            
            Text("\(Int(singleReview?.rating ?? 0.0))")
                .font(.custom(FONT_SEMIBOLD, size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom,5)
            
            StarRatingView(rating: Int(singleReview?.rating ?? 0.0))
                .padding(.bottom,5)
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 0.3)
        }
    }
}

#Preview {
    SingleReviewView()
}
