//
//  SelectStartRatingView.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/5/24.
//

import SwiftUI

struct SelectStartRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<5, id: \.self) { index in
                    Button(action: {
                        self.rating = index + 1 // Increment the rating when the star is clicked
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(index < self.rating ? hexToColor(hex: "#D0B756") : hexToColor(hex: "#E0E0DC"))
                    }
                    .frame(width: geometry.size.width / 5) // Set each star's width to 1/5 of the container's width
                    .buttonStyle(PlainButtonStyle()) // Remove button default style
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                // Calculate the index of the star based on drag position
                                let starWidth = geometry.size.width / 5
                                let newIndex = min(max(0, Int((value.location.x + starWidth / 2) / starWidth)), 4)
                                self.rating = newIndex + 1
                            })
                    )
                }
            }
        }
        .frame(height: 20)
    }
}

#Preview {
    SelectStartRatingView(rating: .constant(0))
}
