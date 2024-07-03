//
//  AttendanceHistoryView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct AttendanceHistoryView: View {
    
    @State var isPresent : Bool = false
    @StateObject var moreViewModel = MoreViewModel()
    
    var body: some View {
        ScrollView {
            
            VStack {
                
                if moreViewModel.attendanceHistory.count == 0 {
                    NoDataFoundView()
                } else {
                    ForEach(moreViewModel.attendanceHistory) { item in
                        
                        SingleAttendanceHistoryView(singleAttendance: item)
                        .padding()
                        .padding(.bottom,10)
                        .background(hexToColor(hex: "#F9F9F7"))
                        .cornerRadius(10)
                        
                        
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                }

                
            }
            .padding(.horizontal)
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .navigationBarItems(leading: CustomTitleBarItems(title: "Attandance History"))
            
        }
        .onAppear {
            moreViewModel.getAttendanceHistory()
        }
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
    }
}

//#Preview {
//    AttendanceHistoryView()
//}
