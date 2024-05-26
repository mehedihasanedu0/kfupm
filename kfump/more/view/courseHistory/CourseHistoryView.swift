//
//  CourseHistoryView.swift
//  kfump
//
//  Created by Mehedi Hasan on 5/5/24.
//

import SwiftUI

struct CourseHistoryView: View {
    
    @StateObject var homeviewModel = HomeViewModel()
    @State var isNavigateToCourseHistoryDetailsView = false
    @State var courseId  = 0
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(homeviewModel.courseHistoryList, id: \.id) { course in
                            SingleEnrolledCourseView(course: course.course!,courseStatus: course.status ?? "")
                                .padding(.bottom,2)
                                .redactShimmer(condition: homeviewModel.isLoading && homeviewModel.courseList.count == 11)
                                .onTapGesture {
                                    print("Course tapped: \(course.course?.id ?? 0)")
                                    courseId = course.course?.id ?? 0
                                    isNavigateToCourseHistoryDetailsView = true
                                }

                        }
                      
                    }.padding(.top,15)
                }

                .padding(.bottom,10)
            }
            .padding(.horizontal)
        }
        .onAppear {
            homeviewModel.getCompletedCourseList()
        }
        .background(hexToColor(hex: "#FFFFFF"))
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Course History"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .navigationDestination(isPresented: $isNavigateToCourseHistoryDetailsView, destination: { CourseHistoryDetailsView(courseId: courseId).navigationBarBackButtonHidden(true) })
    }
}

//#Preview {
//    CourseHistoryView()
//}
