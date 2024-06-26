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
    @State var showSearchView: Bool = false
    @State var isCloseButtonVisible: Bool = true
    
    @State private var filterItemIds: [Int] = []
    
    @State var isNavigateToCourseDetailsView: Bool = false
    
    @State var courseId: Int = 0
    
    
    
    @StateObject var homeviewModel = HomeViewModel()
    
    @StateObject var authenicationViewModel = AuthenicationViewModel()
    @AppStorage(Keys.refreshToken.rawValue) var refreshToken: String?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
    var body: some View {
        
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    
                    
                    VStack {
                        ZStack {
                            
                            SearchView(fieldName: LocalizationSystem.shared.localizedStringForKey(key: SEARCH_COURSES_KEY, comment: ""), value: $searchValue, onCloseTapped: {
                                print("searchValue =>  \(searchValue)")
                                searchValue = ""
                            },isCloseButtonVisible: isCloseButtonVisible)
                            .padding(.top)
                            .onTapGesture {
                                print("onTapGesture => ")
                                showSearchView = true
                                isCloseButtonVisible = true
                            }
                            .onChange(of: searchValue) { newValue in
                                homeviewModel.getCourseListBySearchKey(searchKey: newValue)
                            }
                            .onSubmit {
                                showSearchView = false
                                isCloseButtonVisible = true
                                self.hideKeyboard()
                            }
                            
//                            
//                            Button {
//                                print("Search courses")
//                                showSearchView = true
//                                isCloseButtonVisible = true
//                            } label: {
//                                Rectangle()
//                                    .foregroundColor(.clear)
//                                    .frame(height: 50)
//                            }
                            
                            
                        }
                        
                    }
                    
                    

                    
                   
                    if showSearchView {
                        searchViewLabel
                    }

                    
                    if !showSearchView {
                        
                        
                        if homeviewModel.courseListBySearchKey.count != 0 && searchValue != "" {
                            filterViewLabel
                        } else {
                            browseCourseLabel
                        }
                        
                    
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(homeviewModel.courseList, id: \.id) { course in
//                                    
//                                    Button(action: {
//                                        print("Course tapped: \(course.id)")
//                                        isNavigateToCourseDetailsView = true
//                                        
//                                    }) {
//                                        SingleCourseView(course: course)
//                                            .padding(.bottom,2)
//                                            .redactShimmer(condition: self.homeviewModel.isLoading && self.homeviewModel.courseList.count == 11)
//                                    }
                                    SingleCourseView(course: course)
                                        .padding(.bottom,2)
                                        .redactShimmer(condition: homeviewModel.isLoading && homeviewModel.courseList.count == 11)
                                        .onTapGesture {
                                            courseId = course.id ?? 0
                                            print("courseId \(courseId)")
                                            isNavigateToCourseDetailsView = true
                                        }

                                }
                              
                            }.padding(.top,15)
                        }
                        .onAppear() {
          
                            if homeviewModel.courseListBySearchKey.count == 0 {
                                homeviewModel.getCourseList()
                            }
                            
                        }
                        .onDisappear {
                            searchValue = ""
                        }
                        .padding(.bottom,10)
                    }
                    
                    
                }
                
                if homeviewModel.isLoadingBySearchKey {
                    CustomProgressView()
                }
            }
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal,20)
            .onAppear {

                if Utils.isJWTTokenExpire() {
                    let vm = RefreshTokenRequestModel(refreshToken: refreshToken)
                    authenicationViewModel.refreshToken(body: vm)
                }
            }
            .navigationDestination(isPresented: $isNavigateToCourseDetailsView, destination: { CourseDetailsView(courseId: courseId).navigationBarBackButtonHidden(true) })
        
    }
    
    
    var browseCourseLabel: some View {
        HStack {
            HStack {
                Text(LocalizationSystem.shared.localizedStringForKey(key: BROWSE_KEY, comment: ""))
                    .font(.custom(FONT_BOLD, size: 22))
                    .bold()
                Text(LocalizationSystem.shared.localizedStringForKey(key: COURSE_KEY, comment: ""))
                    .fontWeight(.ultraLight)
                    .font(.custom(FONT_LIGHT, size: 22))
                    .foregroundColor(hexToColor(hex: "#D0B756"))
                
            }
            Spacer()
        }
        .padding(.top,30)
    }
    
    
    var filterViewLabel: some View {
        
        FilterView(totalResult: homeviewModel.courseList.count,filterValue: filterItemIds.count, onFilterTapped: {
            self.presentSheet.toggle()
        })
        .padding(.top, 20)
        .sheet(isPresented: self.$presentSheet) {
            FilterMenuView(presentSheet: $presentSheet, filterItemIds: $filterItemIds)
                .readHeight()
                .onPreferenceChange(HeightPreferenceKey.self) { height in
                    if let height {
                        self.detentHeight = height
                    }
                }
                .presentationDetents([.height(self.detentHeight)])
        }
    
    }    
    
    
    var searchViewLabel: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(homeviewModel.courseList, id: \.id) { course in
                    SingleSearchItem(course: course)
                        .padding(.bottom,2)
                        .onTapGesture {
                            showSearchView = false
                            isCloseButtonVisible = false
                            searchValue = course.title ?? " "
                            self.hideKeyboard()
                            courseId = course.id ?? 0
                            isNavigateToCourseDetailsView = true
                        }
                }
            }
        }
        
    }
    
}

#Preview {
    ExploreView()
}
