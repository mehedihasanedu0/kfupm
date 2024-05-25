//
//  SingleCourseItemView.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/5/24.
//

import SwiftUI

struct SingleCourseItemView: View {
    
    var singleLecture: Lecture!
    
    var body: some View {
        VStack {
            HStack {
                
                Image(getItemIconType(singleLecture.fileExtension ?? ""))
                    .resizable()
                    .frame(width: 20,height: 20)
                    .offset(y: -10)
                
                VStack {
                    Text(singleLecture.title ?? "")
                        .font(.custom(FONT_MEDIUM, size: 14))
                        .foregroundColor(hexToColor(hex: "#333333"))
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    HStack {
                        
                        Text(getItemType(singleLecture.fileExtension ?? ""))
                            .font(.custom(FONT_LIGHT, size: 12))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        
                        Divider()
                            .background(.gray)
                            .frame(width: 4,height: 4)
                            .background(hexToColor(hex: "#7C7C7C"))
                            .cornerRadius(2)
                        
                        Text(singleLecture.fileExtension != "mp4" ? singleLecture.fileExtension ?? "" : "\(singleLecture.duration ?? "") min" )
                            .font(.custom(FONT_LIGHT, size: 12))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .offset(y: -10)
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
        .frame(height: 50)
    }
    
    func getItemType(_ fileExtention : String) -> String {
        switch (fileExtention) {
        case "mp4" : return "Video"
        case "pdf" : return "PDF"
        default:
            return "Assignment"
        }
    }    
    
    func getItemIconType(_ fileExtention : String) -> String {
        switch (fileExtention) {
        case "mp4" : return "ic_video"
        case "pdf" : return "ic_pdf"
        default:
            return "ic_assignment"
        }
    }
}

//#Preview {
//    SingleCourseItemView()
//}
