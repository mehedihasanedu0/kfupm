//
//  MyCourses.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct MyCourses: View {
    
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
                
                myCourseLabel
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(homeviewModel.ongoingCourseList, id: \.id) { course in
                            SingleEnrolledCourseView(course: course.course!, courseStatus: course.status ?? "")
                                .padding(.bottom,2)
                                .redactShimmer(condition: homeviewModel.isLoading && homeviewModel.ongoingCourseList.count == 4)
                                .onTapGesture {
                                    print("Course tapped: \(course.course?.id ?? 0)")
                                    selectedCoureId = course.course?.id ?? 0
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
    
    var myCourseLabel: some View {
        HStack {
            HStack {
                Text("My")
                    .font(.custom(FONT_BOLD, size: 22))
                    .bold()
                Text("Course")
                    .fontWeight(.ultraLight)
                    .font(.custom(FONT_LIGHT, size: 22))
                    .foregroundColor(hexToColor(hex: "#D0B756"))
                
            }
            Spacer()
        }
        .padding(.top,30)
    }
}

#Preview {
    MyCourses()
}
