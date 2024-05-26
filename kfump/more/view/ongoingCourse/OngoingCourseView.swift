//
//  OngoingCourseView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct OngoingCourseView: View {
    
    @StateObject var homeviewModel = HomeViewModel()
    @State var isNavigateToCourseDetailsView = false
    
    @State var selectedCoureId = 0
    @State var selectedCoureTitle = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(homeviewModel.ongoingCourseList, id: \.id) { course in
                            SingleEnrolledCourseView(course: course.course!, courseStatus: course.status ?? "")
                                .padding(.bottom,2)
                                .redactShimmer(condition: homeviewModel.isLoading)
                                .onTapGesture {
                                    print("Course tapped: \(course.id)")
                                    selectedCoureId = course.id ?? 0
                                    selectedCoureTitle = course.course?.title ?? ""
                                    isNavigateToCourseDetailsView = true
                                }

                        }
                      
                    }.padding(.top,15)
                }
                .onAppear() {
                    homeviewModel.getOngoingCourseList()
                }
                .padding(.bottom,10)
            }
            .padding(.horizontal)
        }
        .background(hexToColor(hex: "#FFFFFF"))
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Ongoing Courses"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .navigationDestination(isPresented: $isNavigateToCourseDetailsView, destination: { OngoingCourseDetailsView(courseId: selectedCoureId,courseTitle: selectedCoureTitle).navigationBarBackButtonHidden(true) })
    }
}

#Preview {
    OngoingCourseView()
}
