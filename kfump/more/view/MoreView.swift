//
//  MoreView.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct MoreView: View {
    
    @AppStorage(Keys.IS_LOGIN_D.rawValue) var isLogin: Bool?
    @State var isNavigateToEnrolledCoursesView = false
    @State var isNavigateToOngoingCoursesView = false
    @State var isNavigateToHistoryCoursesView = false
    @State var isNavigateToAttendanceHistoryView = false
    var moreItems: [MoreItems] = MoreItems.sampleData // Replace with your data source
    
    var body: some View {
        ZStack {
            VStack {
                LazyVStack(spacing: 15) {
                    ForEach(moreItems) { item in
                        SingleItemView(isDotViewShow: (item.id == 6),
                                       isBottomDividerShow: item.id != 8,
                                       moreItems: item )
                        .onTapGesture {
                            if isLogin ?? false {
                                handleAction(for: item)
                            }
                            
                        }
                    }
                }.padding(.bottom,20)
            }
        }
        .navigationDestination(isPresented: $isNavigateToEnrolledCoursesView, destination: { EnrolledCoursesView().navigationBarBackButtonHidden(true) })
        .navigationDestination(isPresented: $isNavigateToOngoingCoursesView, destination: { OngoingCourseView().navigationBarBackButtonHidden(true) })
        .navigationDestination(isPresented: $isNavigateToHistoryCoursesView, destination: { CourseHistoryView().navigationBarBackButtonHidden(true) })
    }
    
    func handleAction(for item: MoreItems) {
        switch item.id {
        case 1:
            print("Enrolled Courses")
            isNavigateToEnrolledCoursesView = true
        case 2:
            print("Ongoing Courses")
            isNavigateToOngoingCoursesView = true
        case 3:
            print("Attendance History")
            isNavigateToAttendanceHistoryView = true
        case 4:
            print("HistoryCourses")
            isNavigateToHistoryCoursesView = true
        case 5:
            print("Payment History selected")
            // Log out
//            isShowingConfirmationView.toggle()
        case 6:
            print("Payment History selected")
            // Close Account
//            isNavigateToCloseAccountView = true
        default:
            break
        }
    }
}

#Preview {
    MoreView()
}
