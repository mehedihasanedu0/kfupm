//
//  RatingInformationView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct RatingInformationView: View {
    
    var singleRatingInfo : RatingInfoModel?
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(hexToColor(hex: "#D0B756"))
                
                Text("\(singleRatingInfo?.ratingNumber ?? 0)")
                    .font(.custom(FONT_MEDIUM, size: 14))
                
                
                ProgressView(value: singleRatingInfo?.progress, total: 100)
                    .accentColor(hexToColor(hex: "#D0B756"))
                    .scaleEffect(x: 1, y: 4, anchor: .center)
                    .progressViewStyle(.linear)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(5)
                    .padding(.horizontal)
                
                Text("\(Int(singleRatingInfo?.progress ?? 0.0))%")
                    .font(.custom(FONT_MEDIUM, size: 14))
                
            }
        }
        .padding(.vertical,10)
        
    }
}

#Preview {
    RatingInformationView()
}
