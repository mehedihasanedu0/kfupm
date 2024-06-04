//
//  ViewGardsAndAssignmentExamView.swift
//  kfump
//
//  Created by Mehedi Hasan on 5/6/24.
//

import SwiftUI

struct ViewGardsAndAssignmentExamView: View {
    
    @StateObject var ongoingCourseDetailsViewModel = OngoingCourseDetailsViewModel()
    let courseId : Int!
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    
                    Text("Every new product, whether it’s an app or a physical object, follows a specific set of steps that take it from the first spark of an idea to the release of the final product. This is called the product development life cycle.")
                        .font(.custom(FONT_LIGHT, size: 15))
                        .padding(.top)
                    
                    
                    ForEach(ongoingCourseDetailsViewModel.viewGurdList) { lecture in
                        SingleGirdView(singleGurd: lecture)
                            .padding(.bottom,2)
                            .padding(.top,10)
                        
                    }
                    
                }
            }

            
//            if ongoingCourseDetailsViewModel.isLoading {
//                CustomProgressView()
//            }
     
        }
        .redactShimmer(condition: ongoingCourseDetailsViewModel.isLoading)
        .padding(.horizontal)
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .onAppear {
            ongoingCourseDetailsViewModel.viewGirds(courseId: courseId)
        }
        .navigationBarItems(leading: CustomTitleBarItems(title: "View grads of assignments & exams"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)


    }
    
}

//#Preview {
//    ViewGardsAndAssignmentExamView()
//}
