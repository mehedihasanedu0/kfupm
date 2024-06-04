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
            
            if singleLecture.classTypeName == "Grads of Assignment" {
                viewGard
                    .padding(15)
            } else {
                singleLectureView
                    .padding(.horizontal,30)
            }
            
            
        }
        .frame(height: 50)
        
    }
    
    var viewGard: some View {
        
        VStack {
            HStack {
                Image("ic_view_gurd")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .offset(y: -10)
                
                VStack {
                    Text(singleLecture.title ?? "")
                        .font(.custom(FONT_MEDIUM, size: 14))
                        .foregroundColor(hexToColor(hex: "#333333"))
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    HStack {
                        Text(singleLecture.classTypeName ?? "")
                            .font(.custom(FONT_LIGHT, size: 12))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        
                        Spacer()
                    }
                    
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .padding(10)
        }
        .background(hexToColor(hex: "#007D40",alpha: 0.2))
        .cornerRadius(12)
        
    }
    
    
    var singleLectureView: some View {
        HStack {
            
            Image((singleLecture.isRead ?? false) ? "ic_read_lecture" : getItemIconType(singleLecture.fileExtension ?? ""))
                .resizable()
                .frame(width: 20,height: 20)
                .offset(y: -10)
            
            VStack {
                Text(singleLecture.title ?? "")
                    .font(.custom(FONT_MEDIUM, size: 14))
                    .foregroundColor(hexToColor(hex: "#333333"))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack {
                    
                    Text(getItemTypeByClassType(singleLecture.classTypeName ?? "",singleLecture.fileExtension ?? ""))
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
    
    
    func getItemTypeByClassType(_ classType : String,_ fileExtention : String) -> String {
        switch (classType) {
        case "Class" : return getItemType(fileExtention)
        case "Video" : return "Video"
        case "Assignment" : return "Assignment"
        case "Quiz" : return "Quiz"
        case "Survey" : return "Survey"
        default:
            return "Assignment"
        }
    }
    
    func getItemType(_ fileExtention : String) -> String {
        switch (fileExtention) {
        case "mp4" : return "Video"
        case "pdf" : return "PDF"
        case "png" : return "Png"
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
