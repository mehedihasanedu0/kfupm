//
//  CourseDetailsView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct CourseDetailsView: View {
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                HStack {
                    Text("Syllabus")
                        .font(.custom(FONT_BOLD, size: 16))
                    Spacer()
                }           
                
                ForEach(RatingInfoModel.sampleData) { item in
                    SingleSyllabusView()
                    
                    Divider()
                }
                .padding(.top,8)
                .padding(.bottom,10)
                
                HStack {
                    Text("Class Routing")
                        .font(.custom(FONT_BOLD, size: 16))
                    Spacer()
                }
                .padding(.top,15)
                
                ClassRoutineView()
                    .padding(.top,8)
                

                HStack {
                    Text("Reviews")
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                    Spacer()
                }
                .padding(.vertical)
                
                reviewView
                
                
            }
            .padding(.horizontal,20)
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: COURSE_KEY, comment: "")))
        }
    }
    
    var reviewView: some View {
        
        VStack {

            VStack {
                
                HStack {
                    Text("Rating Information")
                        .font(.custom(FONT_MEDIUM, size: 18))
                    Spacer()
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.")
                    .font(.custom(FONT_LIGHT, size: 14))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.vertical, 10)
                    
                
                Divider()
                    .padding(.vertical, 15)
                
                HStack {
                    Text("4.7")
                        .font(.custom(FONT_BOLD, size: 18))
                    Text("out of 5")
                        .font(.custom(FONT_REGULAR, size: 14))
                    Spacer()
                }
                
                
                ForEach(RatingInfoModel.sampleData) { item in
                    RatingInformationView()
                }
                
                Divider()
                    .padding(.vertical, 15)
                
                
                HStack {
                    Text("Showing  3 Out Of 20 ")
                        .font(.custom(FONT_MEDIUM, size: 18))
                    Spacer()
                }
                
                ForEach(RatingInfoModel.sampleData) { item in
                    SingleReviewView()
                        .padding(.bottom,5)
                }
                .padding(.bottom)
                
            }
            .padding(.horizontal)

           
        }
        .padding(.top,8)
        .frame(maxWidth: .infinity)
        .background(hexToColor(hex: "#F9F9F7"))
        .cornerRadius(12)
        
        
        
    }
}

#Preview {
    CourseDetailsView()
}
