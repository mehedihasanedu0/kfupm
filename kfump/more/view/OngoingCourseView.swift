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
                            SingleEnrolledCourseView(course: course)
                                .padding(.bottom,2)
                                .onTapGesture {
                                    print("Course tapped: \(course.id)")
                                    isNavigateToCourseDetailsView = true
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
    }
}

#Preview {
    OngoingCourseView()
}
