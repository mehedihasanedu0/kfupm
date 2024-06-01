//
//  OngoingCourseDetailsView.swift
//  kfump
//
//  Created by Mehedi Hasan on 23/5/24.
//

import SwiftUI

struct OngoingCourseDetailsView: View {
    
    @StateObject var courseDetailsViewModel = OngoingCourseDetailsViewModel()
    
    @State var isNavigateToPDFView = false
    @State var isNavigateToQuizeView = false
    @State var isNavigateToVideoView = false
    @State var isNavigateToImageView = false
    
    var courseId = 0
    var courseTitle = ""
    @State var selectedClassItemUrl = ""
    @State var selectedLectureTitle = ""
    
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
                                Text("\(courseDetailsViewModel.ongoingCourse?.videoCount ?? 0) Videos")
                                    .font(.custom(FONT_LIGHT, size: 12))
                            }
                            
                            HStack {
                                Image("ic_pdf")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Text("\(courseDetailsViewModel.ongoingCourse?.pdfCount ?? 0) Pdf")
                                    .font(.custom(FONT_LIGHT, size: 12))
                            }
                            .padding(.leading,10)
                            
                            HStack {
                                Image("ic_assignment")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                Text("\(courseDetailsViewModel.ongoingCourse?.assignmentCount ?? 0) Assignments")
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
              
                        ForEach(courseDetailsViewModel.ongoingCourse?.data ?? [], id: \.id) { lecture in
                            
                            SingleCourseItemView(singleLecture: lecture)
                                .padding(.bottom,2)
                                .padding(.top,10)
                                .onTapGesture {
                                    if !(lecture.isRead ?? false) {
                                        courseDetailsViewModel.readLecture(lectureId: lecture.id ?? 0)
                                    }
                                    
                                    
                                    if (lecture.classTypeName ?? "" == "Quiz") {
                                        self.isNavigateToQuizeView = true
                                    }
                                    self.selectedClassItemUrl = lecture.file ?? ""
                                    self.selectedLectureTitle = lecture.title ?? ""
                                    showLectureItem(fileExtention: lecture.fileExtension ?? "")
                                }
                            
                            Divider()
                        }
                    }
                    .padding()
                    .background(.white)
                    
                }
                .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .navigationBarItems(leading: CustomTitleBarItems(title: "Ongoing Course details"))
                .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
                .navigationDestination(isPresented: $isNavigateToPDFView, destination: { PDFViewerView(url: selectedClassItemUrl,title: selectedLectureTitle).navigationBarBackButtonHidden(true) })                
                .navigationDestination(isPresented: $isNavigateToImageView, destination: { ImageViewerView(url: selectedClassItemUrl,title: selectedLectureTitle).navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToVideoView, destination: { VideoPlayerView(url: selectedClassItemUrl,title: selectedLectureTitle).navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToQuizeView, destination: { QuizeView(title: selectedLectureTitle).navigationBarBackButtonHidden(true) })
            }
        }
        .onAppear {
            courseDetailsViewModel.getOngoingCourseDetails(courseId: 3)
        }
        
        .background(hexToColor(hex: "#F9F9F7"))
        
    }
    
    var takeActionButtonView: some View {
        
        HStack {
            
            Button(action: {
                
                
            }) {
                HStack {
                    
                    Text("Take Action")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(.white)
                    //                        .padding(.leading,15)
                    
                    Image("drop_arrow")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(.leading,5)
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
}

//#Preview {
//    OngoingCourseDetailsView()
//}
