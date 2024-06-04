//
//  SingleGirdView.swift
//  kfump
//
//  Created by Mehedi Hasan on 5/6/24.
//

import SwiftUI

struct SingleGirdView: View {
    
    var singleGurd : TraineeGrade?
    var body: some View {
        VStack {
            HStack {
                Text("\(LocalizationSystem.shared.localizedStringForKey(key: DATE_KEY, comment: "")):")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text(singleGurd?.date ?? "")
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,5)
            
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("\(LocalizationSystem.shared.localizedStringForKey(key: COURSE_NAME_KEY, comment: "")): ")
                    .font(.custom(FONT_MEDIUM, size: 14)) +
                Text(singleGurd?.title ?? "")
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            
            HStack {
                Text(singleGurd?.status ?? "")
                    .font(.custom(FONT_MEDIUM, size: 14))
                    .padding(.vertical,6)
                    .padding(.horizontal,15)
                    .foregroundColor(singleGurd?.status == "Pending" ? hexToColor(hex: "#007D40") : hexToColor(hex: "#D0B756"))
                    .background(singleGurd?.status == "Pending"  ? hexToColor(hex: "#007D40",alpha: 0.2) : hexToColor(hex: "#D0B756",alpha: 0.2))
                    .cornerRadius(15)
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    SingleGirdView()
}
