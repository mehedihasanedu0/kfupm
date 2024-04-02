//
//  ExploreView.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State var searchValue: String = ""
    @State var presentSheet :Bool = false
    @State var detentHeight: CGFloat = 0
    
    @StateObject var homeviewModel = HomeViewModel()
    
//    var courses: [Course] = Course.sampleData // Replace with your data source
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    
                    SearchView(fieldName: "Search courses", value: $searchValue)
                        .padding(.top)
                    
                    
                    //                    browseCourseLabel
                    
                    filterViewLabel
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(homeviewModel.courseList, id: \.id) { course in
                                SingleCourseView(course: course)
                                    .padding(.bottom,2)
                            }
                        }.padding(.top,15)
                    }
                    .onAppear() {
                        homeviewModel.getCourseList()
                    }
                    .padding(.bottom,10)
                    
                    
                }
                
                if homeviewModel.isLoading {
                    CustomProgressView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal,20)
            
        }
    }
    
    
    var browseCourseLabel: some View {
        HStack {
            HStack {
                Text("Browse")
                    .font(.custom(FONT_NAME, size: 22))
                    .bold()
                Text("Course")
                    .fontWeight(.ultraLight)
                    .font(.custom(FONT_NAME, size: 22))
                    .foregroundColor(hexToColor(hex: "#D0B756"))
                
            }
            Spacer()
        }
        .padding(.top,30)
    }
    
    
    var filterViewLabel: some View {
        
        FilterView(onFilterTapped: {
            self.presentSheet.toggle()
        })
        .padding(.top, 20)
        .sheet(isPresented: self.$presentSheet) {
            FilterMenuView(presentSheet: $presentSheet)
                .readHeight()
                .onPreferenceChange(HeightPreferenceKey.self) { height in
                    if let height {
                        self.detentHeight = height
                    }
                }
                .presentationDetents([.height(self.detentHeight)])
        }
    
    }
    
}

//#Preview {
//    ExploreView()
//}
