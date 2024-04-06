//
//  SingleSearchItem.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/4/24.
//

import SwiftUI

struct SingleSearchItem: View {
    
    var course: Course
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                WebImageView(imageUrl: course.coverImage ?? "")
                    .frame(width: 50, height: 50)
                    .scaledToFill()
                    .cornerRadius(8)

                VStack(alignment: .leading) {
                    Text(course.title ?? "")
                        .font(.custom(FONT_BOLD, size: 14))
                    
                    Text("Google")
                        .font(.custom(FONT_LIGHT, size: 14))
                        .foregroundColor(hexToColor(hex: "#7C7C7C"))
                }
                
                Spacer()
                
            
            }
            
            Divider()
                .padding(.vertical,5)
        }
      
        
        
        
    }
}

//#Preview {
//    SingleSearchItem(course: nil)
//}
