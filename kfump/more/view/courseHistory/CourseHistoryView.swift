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
                            SingleEnrolledCourseView(course: course.course!)
                                .padding(.bottom,2)
                                .onTapGesture {
                                    print("Course tapped: \(course.id)")
                                    isNavigateToCourseHistoryDetailsView = true
                                }

                        }
                      
                    }.padding(.top,15)
                }
                .onAppear() {
    //                homeviewModel.getCourseList()
                }
                .padding(.bottom,10)
            }
            .padding(.horizontal)
        }
        .background(hexToColor(hex: "#FFFFFF"))
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Ongoing Courses"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .navigationDestination(isPresented: $isNavigateToCourseHistoryDetailsView, destination: { CourseHistoryDetailsView().navigationBarBackButtonHidden(true) })
    }
}

#Preview {
    CourseHistoryView()
}