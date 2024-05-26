//
//  EnrolledCoursesView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct EnrolledCoursesView: View {
    
    @StateObject var homeviewModel = HomeViewModel()
    @State var isNavigateToCourseDetailsView = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(homeviewModel.enrolledCourseList, id: \.id) { course in
                            SingleEnrolledCourseView(course: course.course!,courseStatus: course.status ?? "")
                                .padding(.bottom,2)
                                .redactShimmer(condition: homeviewModel.isLoading && homeviewModel.enrolledCourseList.count == 6)
                                .onTapGesture {
                                    print("Course tapped: \(course.id)")
                                    isNavigateToCourseDetailsView = true
                                }

                        }
                      
                    }.padding(.top,15)
                }
                .padding(.bottom,10)
            }
            .padding(.horizontal)
        }
        .onAppear {
            homeviewModel.getEnrolledCourseList()
        }
        .background(hexToColor(hex: "#FFFFFF"))
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Enrolled Courses"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
    }
}

#Preview {
    EnrolledCoursesView()
}
