//
//  CourseDetailsView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct CourseDetailsView: View {
    
    @State var isEntollTypeSingle: Bool = true
    @State var isViewHidden: Bool = true
    @State var isNavigateToCheckoutView: Bool = false
    @State var isShowingGroupEnrolledView: Bool = false
    
    
    @State private var selectedTab = "About"
    let tabs = ["About", "Instructor", "Syllabus", "Class Routine"]
    
    @StateObject var courseDetailsViewModel = CourseDetailsViewModel()
    @State var isNavigateToEnrolledCourseView : Bool = false
    
    var courseId : Int!
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                
                
                VStack {
                    
                    VStack {
                        
                        if courseDetailsViewModel.courseData != nil {
                            WebImageView(imageUrl: courseDetailsViewModel.courseData?.coverImage ?? "")
                                .aspectRatio(18/13, contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                                .cornerRadius(12)
                                .padding(.top,30)
                            
                            
                        } else {
                            Image("nature")
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                                .cornerRadius(12)
                                .padding(.top,30)
                        }
                        
                        
                        Text(courseDetailsViewModel.courseData?.title ?? "")
                            .font(.custom(FONT_BOLD, size: 20))
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(courseDetailsViewModel.courseData?.subtitle ?? "")
                            .font(.custom(FONT_LIGHT, size: 16))
                            .padding(.vertical,5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        
                        enrolledButtonView
                    }
                    .padding(.horizontal,20)
                    
                    
                    menuListView
                        .shadow(color: .gray, radius: 0.2, x: 0, y: 0)
                    
                    VStack {
                        
                        
                        
                        
                        HStack {
                            Text("About this Course")
                                .font(.custom(FONT_BOLD, size: 16))
                            Spacer()
                        }
                        .padding(.top,30)
                        
                        
                        Text(courseDetailsViewModel.courseData?.description ?? "")
                            .font(.custom(FONT_LIGHT, size: 16))
                            .padding(.vertical,5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        InstructorView()
                        
                        
                        HStack {
                            Text("Syllabus")
                                .font(.custom(FONT_BOLD, size: 16))
                            Spacer()
                        }
                        .padding(.top,30)
                        
                        ForEach(courseDetailsViewModel.scyllabusInfo) { item in
                            SingleSyllabusView(singleSyllabus: item)
                            
                            Divider()
                        }
                        .padding(.top,8)
                        .padding(.bottom,10)
                        
                        HStack {
                            Text("Class Routing")
                                .font(.custom(FONT_BOLD, size: 16))
                            Spacer()
                        }
                        .padding(.top,15)
                        
                        ClassRoutineView(singleClassRoutine: courseDetailsViewModel.classRoutineInfo)
                            .padding(.top,8)
                        
                        
                        HStack {
                            Text("Reviews")
                                .font(.custom(FONT_SEMIBOLD, size: 16))
                            Spacer()
                        }
                        .padding(.vertical)
                        
                        reviewView
                        
                    }
                    .padding(.horizontal,20)
                    
                    
                    
                    
                }
                .redactShimmer(condition: courseDetailsViewModel.isLoading)
                .onAppear {
                    print("courseId \(courseId)")
                    if courseDetailsViewModel.courseData == nil {
                        courseDetailsViewModel.courseDetails(courseId: courseId)
                    }
                    
                }
                .background(.white)
                .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: COURSE_KEY, comment: "")))
                .navigationDestination(isPresented: $isNavigateToCheckoutView, destination: { CheckoutView(enrolledData: courseDetailsViewModel.enrolledData).navigationBarBackButtonHidden(true) })   

                
                
                
            }
            
            
            if isShowingGroupEnrolledView {
                groupEnrolledView
            }
            
            
            if courseDetailsViewModel.isLoadingEnrollment {
                CustomProgressView()
            }
            
//            ToastView(isPresented: $courseDetailsViewModel.isLoadingEnrollment, duration: 2.0) {
//                CustomTost(message: courseDetailsViewModel.dialogMessage)
//            }
            
        }
    }
    
    
    
    
    var groupEnrolledView: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowingGroupEnrolledView = false
                }
            
            GroupEnrolledView(
                courseId: courseId,
                title: "Enrolment as a Group",
                message: "You can send the invitation at most 5 people at a time. They will get notification through email and need to accept the invitation in order to join.",
                onConfirm: {
                    // Handle Yes action
                    isShowingGroupEnrolledView = false
                    let vm = EnrolledRequestModel(courseId: courseId, enrolledType: "Group")
                    courseDetailsViewModel.enrolled(body: vm) { result in
                        if result {
                            isNavigateToCheckoutView = true
                        }
                    }
                    
                },
                onCancel: {
                    // Handle No action
                    isShowingGroupEnrolledView = false
                }
            )
            .transition(.scale)
        }
        
    }
    
    var enrolledButtonView: some View {
        
        VStack {
            HStack {
                Button(action: {
                    self.isEntollTypeSingle = true
                    let vm = EnrolledRequestModel(courseId: courseId, enrolledType: "Single")
                    courseDetailsViewModel.enrolled(body: vm) { result in
                        if result {
                            self.isNavigateToCheckoutView = true
                        }
                    }
                    
                }) {
                    Text("Enroll Now")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(isEntollTypeSingle ? .white : hexToColor(hex: "#007D40"))
                        .padding(.horizontal,20)
                    
                    
                }
                
                .frame(height: 45)
                .background(isEntollTypeSingle ? hexToColor(hex: "#007D40") : .white)
                .cornerRadius(22)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(isEntollTypeSingle ? Color .clear : hexToColor(hex: "#007D40"), lineWidth: 2)
                }
                
                
                Button(action: {
                    self.isEntollTypeSingle = false
                    self.isShowingGroupEnrolledView  = true
                    
                }) {
                    Text("Enrolment as a Group")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(isEntollTypeSingle ? hexToColor(hex: "#007D40") : .white)
                        .bold()
                        .padding(.horizontal,20)
                    
                }
                
                .frame(height: 45)
                .background(isEntollTypeSingle ? .white : hexToColor(hex: "#007D40"))
                .cornerRadius(22)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(isEntollTypeSingle ? hexToColor(hex: "#007D40") : Color .clear, lineWidth: 2)
                }
                
                Spacer()
            }
            .padding(.top,30)
        }
        
    }
    
    
    var menuListView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(tabs, id: \.self) { tab in
                    Button(action: {
                        self.selectedTab = tab
                    }) {
                        Text(tab)
                            .font(.custom(self.selectedTab == tab ? FONT_SEMIBOLD : FONT_MEDIUM, size: 14))
                            .padding(.vertical,9)
                            .padding(.horizontal,20)
                            .background(self.selectedTab == tab ? hexToColor(hex: "#007D40") : .white)
                            .foregroundColor(self.selectedTab == tab ? Color.white : Color.gray)
                            .cornerRadius(20)
                        
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(self.selectedTab == tab ? Color.clear : hexToColor(hex: "#E5E5D9"), lineWidth: 1)
                    }
                }
            }
            .padding(.top,25)
            .padding(.bottom,25)
            .padding(.leading)
            
        }
        .background(.white)
        .padding(.top)
    }
    
    var reviewView: some View {
        
        VStack {
            
            VStack {
                
                HStack {
                    Text("Rating Information")
                        .font(.custom(FONT_MEDIUM, size: 18))
                    Spacer()
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor.")
                    .font(.custom(FONT_LIGHT, size: 14))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.vertical, 10)
                
                
                Divider()
                    .padding(.vertical, 15)
                
                HStack {
                    Text("4.7")
                        .font(.custom(FONT_BOLD, size: 18))
                    Text("out of 5")
                        .font(.custom(FONT_REGULAR, size: 14))
                    Spacer()
                }
                
                StarRatingView(rating: 3)
                    .padding(.bottom,5)
                
                
                ForEach(RatingInfoModel.sampleData) { item in
                    RatingInformationView(singleRatingInfo: item)
                }
                
                Divider()
                    .padding(.vertical, 15)
                
                
                HStack {
                    Text("Showing  3 Out Of 20 ")
                        .font(.custom(FONT_MEDIUM, size: 18))
                    Spacer()
                }
                
                ForEach(CourseReviewModel.sampleData) { item in
                    SingleReviewView(singleReview: item)
                        .padding(.bottom,5)
                }
                .padding(.bottom)
                
            }
            .padding(.horizontal)
            
            
        }
        .padding(.top,8)
        .frame(maxWidth: .infinity)
        .background(hexToColor(hex: "#F9F9F7"))
        .cornerRadius(12)
        
        
        
    }
}

//#Preview {
//    CourseDetailsView()
//}
