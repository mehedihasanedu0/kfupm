//
//  OngoingCourseDetailsView.swift
//  kfump
//
//  Created by Mehedi Hasan on 23/5/24.
//

import SwiftUI

struct OngoingCourseDetailsView: View {
    
    @StateObject var ongoingDetailsViewModel = OngoingCourseDetailsViewModel()
    @StateObject var courseDetailsViewModel = CourseDetailsViewModel()
    
    @State var isNavigateToPDFView = false
    @State var isNavigateToQuizeView = false
    @State var isNavigateToVideoView = false
    @State var isNavigateToImageView = false
    @State var isNavigateToAssignmentView = false
    
    @State private var isShowingConfirmationView = false
    @State private var isShowingSuccessfullView = false
    
    var courseId = 0
    var courseTitle = ""
    @State var selectedClassItemUrl = ""
    @State var selectedLectureTitle = ""
    @State var selectedLectureId = 0
    
    let courseStatuses = ["Withdraw"]
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    
                    VStack {
                        HStack {
                            HStack {
                                Image("ic_video")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Text("\(ongoingDetailsViewModel.ongoingCourse?.videoCount ?? 0) Videos")
                                    .font(.custom(FONT_LIGHT, size: 12))
                            }
                            
                            HStack {
                                Image("ic_pdf")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Text("\(ongoingDetailsViewModel.ongoingCourse?.pdfCount ?? 0) Pdf")
                                    .font(.custom(FONT_LIGHT, size: 12))
                            }
                            .padding(.leading,10)
                            
                            HStack {
                                Image("ic_assignment")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Text("\(ongoingDetailsViewModel.ongoingCourse?.assignmentCount ?? 0) Assignments")
                                    .font(.custom(FONT_LIGHT, size: 12))
                            }
                            .padding(.leading,10)
                            
                        }
                        .padding(.top)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        Text("User experience (UX) designers focus on the experience that users have while using products like websites, apps, and physical objects. UX designers make those everyday interactions useful, enjoyable, and accessible.")
                            .font(.custom(FONT_LIGHT, size: 15))
                            .padding(.top)
                        
                        takeActionButtonView
                        
                        
                    }
                    .padding(.horizontal,30)
                    .padding(.bottom,30)
                    
                    VStack {
              
                        ForEach(ongoingDetailsViewModel.ongoingCourse?.data ?? [], id: \.id) { lecture in
                            
                            SingleCourseItemView(singleLecture: lecture)
                                .padding(.bottom,2)
                                .padding(.top,10)
                                .onTapGesture {
                                    if !(lecture.isRead ?? false) {
                                        ongoingDetailsViewModel.readLecture(lectureId: lecture.id ?? 0)
                                    }
                                    
                                    
                                    self.selectedClassItemUrl = lecture.file ?? ""
                                    self.selectedLectureTitle = lecture.title ?? ""
                                    self.selectedLectureId = lecture.id ?? 0
                                    
                                    if (lecture.classTypeName ?? "" == "Quiz") {
                                        self.isNavigateToQuizeView = true
                                        return
                                    }
                                    
                                    if (lecture.classTypeName ?? "" == "Assignment" && lecture.fileExtension ?? "" == "pdf" ) {
                                        self.isNavigateToAssignmentView = true
                                        return
                                    }

                                    showLectureItem(fileExtention: lecture.fileExtension ?? "")
                                }
                            
                            Divider()
                        }
                    }
                    .padding()
                    .background(.white)
                    
                }
                .redactShimmer(condition: ongoingDetailsViewModel.isLoading)
                .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .navigationBarItems(leading: CustomTitleBarItems(title: "Ongoing Course details"))
                .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
                .navigationDestination(isPresented: $isNavigateToPDFView, destination: { PDFViewerView(url: selectedClassItemUrl,title: selectedLectureTitle).navigationBarBackButtonHidden(true) })                
                .navigationDestination(isPresented: $isNavigateToImageView, destination: { ImageViewerView(url: selectedClassItemUrl,title: selectedLectureTitle).navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToVideoView, destination: { VideoPlayerView(url: selectedClassItemUrl,title: selectedLectureTitle).navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToQuizeView, destination: { QuizeView(title: selectedLectureTitle).navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToAssignmentView, destination: { PDFSubmitView(url: selectedClassItemUrl,lectureId: selectedLectureId).navigationBarBackButtonHidden(true) })
            }
            
            
            if isShowingConfirmationView {
                
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowingConfirmationView = false
                    }
                
                CustomConfirmationView(
                    title: "Are you sure?",
                    message: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly",
                    onConfirm: {
                        // Handle Yes action
                        isShowingConfirmationView = false
                        courseStatusChangeToWithdraw()
                        
                        
                    },
                    onCancel: {
                        // Handle No action
                        isShowingConfirmationView = false
                    }
                )
                .transition(.scale)
            }            
            
            if isShowingSuccessfullView {
                
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowingSuccessfullView = false
                    }
                
                CustomSuccessView(
                    title: "Request Sent Successfully",
                    message: "Your course has been created successfully. Please wait for admin approval. After that, your course will be withdraw.",
                    onCancel: {
                        // Handle No action
                        isShowingSuccessfullView = false
                    }
                )
                .transition(.scale)
            }
            
        }
        .onAppear {
            ongoingDetailsViewModel.getOngoingCourseDetails(courseId: courseId)
        }
        
        .background(hexToColor(hex: "#F9F9F7"))
        
    }
    
    var takeActionButtonView: some View {
        
        HStack {
            
            Button(action: {
                
                
            }) {
                
                HStack {
                    
                    Menu {
                        ForEach(courseStatuses, id: \.self) { status in
                            Button(action: {
                                isShowingConfirmationView = true
                            }) {
                                Text(status)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Take Action")
                                .foregroundColor(.white)
                                .padding(.leading,10)
                            
                            Image("drop_arrow")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }
                    
                }
                
                
                
            }
            
            .frame(width: 156, height: 45)
            .background(hexToColor(hex: "#007D40"))
            .cornerRadius(22)
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
            }
            
            Spacer()
        }
        .padding(.top)
    }
    
    func showLectureItem(fileExtention: String) {
        switch (fileExtention) {
        case "mp4" : isNavigateToVideoView = true
        case "pdf" : isNavigateToPDFView = true
        case "png" : isNavigateToImageView = true
        default:
            print("Item Extention Not Match")
        }
    }   
    
    func courseStatusChangeToWithdraw() {
        let vm = CourseStatusRequestModel(courseId: courseId, status: "DROP")
        print("vm => \(vm)")
        courseDetailsViewModel.courseStatusChange(body: vm) { resilt in
            isShowingSuccessfullView = true
        }
    }
}

//#Preview {
//    OngoingCourseDetailsView()
//}
