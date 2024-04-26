//
//  StarRatingView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct StarRatingView: View {
    
    var rating: Int = 3
    
    var body: some View {
        HStack {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(index < rating ? hexToColor(hex: "#D0B756") : hexToColor(hex: "#E0E0DC"))
            }
            
            Spacer()
        }
        .frame(height: 20)
    }
    
}


#Preview {
    StarRatingView()
}
