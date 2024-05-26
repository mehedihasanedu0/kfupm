//
//  CourseHistoryDetailsView.swift
//  kfump
//
//  Created by Mehedi Hasan on 5/5/24.
//

import SwiftUI

struct CourseHistoryDetailsView: View {
    
    
    @StateObject var courseDetailsViewModel = CourseDetailsViewModel()
    @StateObject var pdfNetworkManager = PDFNetworkManager()
    @State var isNavigateToEnrolledCourseView : Bool = false
    @State private var showActivityViewController = false
    @State private var showActivityViewControllerForDigital = false
    
    var courseId : Int!
    
    @State var rating: Int = 0
    @State var reviewTextView: String = ""
    @State private var showToast = false
    @State private var count = 0
    
    @State private var pdfURL: URL?
    @State private var errorMessage: String?
    
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
                        
                        
                        Text("About this course")
                            .font(.custom(FONT_BOLD, size: 20))
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(courseDetailsViewModel.courseData?.description ?? "")
                            .font(.custom(FONT_LIGHT, size: 16))
                            .padding(.vertical,5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        byTheNUmber
                        
                        certificate
                        
                        description
                        
                        
                        InstructorView(instructor: courseDetailsViewModel.instructor)
                        
                        ratingInformation
                            .padding(.bottom,40)
                        
                        
                    }
                    .padding(.horizontal,20)
                }
                
            }
            
            if courseDetailsViewModel.isLoadingForCreateReview {
                CustomProgressView()
            }
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: "Review Create Successfully")
            }
            
        }
        .redactShimmer(condition: courseDetailsViewModel.isLoading && courseDetailsViewModel.courseData == nil)
        .onAppear {
            print("courseId -< \(courseId)")
            courseDetailsViewModel.courseDetails(courseId: courseId)
        }
        .background(hexToColor(hex: "#FFFFFF"))
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Course History Details"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .hideKeyboardOnTap()
        .sheet(isPresented: $showActivityViewController) {
            ActivityViewController(activityItems: [pdfNetworkManager.transcriptPDFData!])
                }        
        .sheet(isPresented: $showActivityViewControllerForDigital) {
            ActivityViewController(activityItems: [pdfNetworkManager.digitalCertificatePDFData!])
                }
//        .navigationDestination(isPresented: $isNavigateToCourseHistoryDetailsView, destination: { CourseHistoryDetailsView().navigationBarBackButtonHidden(true) })
        
    }

    
    var byTheNUmber : some View {
        VStack {
            Text("By the numbers")
                .font(.custom(FONT_BOLD, size: 20))
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Skill level: All Levels")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Students: 418")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Languages: Arbi")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Captions: No")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Lectures: 16")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Video: 3.5 total hour")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Divider()
                .padding(.vertical, 15)
            
        }
        
        
    }
    
    var certificate : some View {
        VStack {
            Text("Certificates")
                .font(.custom(FONT_BOLD, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Download Transcripts of the completed course")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack {
                Button(action: {
                    pdfNetworkManager.downloadgenarateTranscriptPDF(courseID: 28)
                    
                }) {
                    Text("Download Now")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                    
                    
                }
                .onChange(of: pdfNetworkManager.transcriptPDFData) { newData in
                    if let data = newData {
                         pdfNetworkManager.savePDFToFilesApp(data: data, fileName: "transcript") { success in
                            if success {
                                print("PDF saved successfully.")
                                showActivityViewController = true
                            } else {
                                print("Failed to save PDF.")
                            }
                        }
                    }
                }
                .frame(height: 45)
                .background(hexToColor(hex: "#007D40"))
                .cornerRadius(22)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
                }
                
                Spacer()
            }
            .padding(.top,10)
            
            Text("Download digital certificate")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .padding(.top,15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            HStack {
                Button(action: {
                    pdfNetworkManager.downloadDigitalCertificatePDF(courseID: 28)
                    
                }) {
                    Text("Download Now")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(hexToColor(hex: "#007D40"))
                        .padding(.horizontal,20)
                    
                    
                }
                .onChange(of: pdfNetworkManager.digitalCertificatePDFData) { newData in
                    if let data = newData {
                         pdfNetworkManager.savePDFToFilesApp(data: data, fileName: "digitalCertificate") { success in
                            if success {
                                showActivityViewControllerForDigital = true
                            } else {
                                print("Failed to save PDF.")
                            }
                        }
                    }
                }
                .frame(height: 45)
                .background(.white)
                .cornerRadius(22)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
                }
                
                Spacer()
            }
            .padding(.top,10)
            
            Divider()
                .padding(.vertical, 15)
            
        }
    }
    
    var description : some View {
        VStack {
            Text("Description")
                .font(.custom(FONT_BOLD, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(courseDetailsViewModel.courseData?.description ?? "")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("What you’ll learn")
                .font(.custom(FONT_MEDIUM, size: 20))
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface In publishing and graphic design.")
                .font(.custom(FONT_LIGHT, size: 16))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            Divider()
                .padding(.vertical, 15)
            
        }
    }
    
    var ratingInformation: some View {
        VStack {
            HStack {
                Text(LocalizationSystem.shared.localizedStringForKey(key: RATING_INFORMATION_KEY, comment: ""))
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
                Text("\(doubleFormat(courseDetailsViewModel.courseData?.ratingAverage ?? 0))")
                    .font(.custom(FONT_BOLD, size: 18))
                Text("out of 5")
                    .font(.custom(FONT_REGULAR, size: 14))
                Spacer()
            }
            
            StarRatingView(rating: Int(courseDetailsViewModel.courseData?.ratingAverage ?? 0.0))
                .padding(.bottom,5)
            
            
            if let ratingPercentage = courseDetailsViewModel.ratingPercentage {
                ForEach(ratingPercentage.sorted(by: { $0.key < $1.key }), id: \.key) { (key, value) in
                    RatingInformationView(singleRatingNumber: key,singleRatingProgress: value)
                }
            }
            
            Divider()
                .padding(.vertical, 15)
            
            
            writeReviewAndRating
            
            
            if let ratingInfo = courseDetailsViewModel.ratingInfo {
                
                if ratingInfo.count != 0 {
                    
                    Divider()
                        .padding(.vertical, 15)
                    
                    
                    
                    HStack {
                        Text("Showing  3 Out Of \(courseDetailsViewModel.ratingInfo?.count ?? 0) ")
                            .font(.custom(FONT_MEDIUM, size: 18))
                        Spacer()
                    }
                }
                
                
                ForEach(ratingInfo) { item in
                    SingleReviewView(singleReview: item)
                        .padding(.bottom,5)
                }
                .padding(.bottom)
            }
            
        }
    }
    
    
    var writeReviewAndRating: some View {
        VStack {
            Text("Write your rating and review")
                .font(.custom(FONT_SEMIBOLD, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Your Rating")
                .font(.custom(FONT_MEDIUM, size: 14))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SelectStartRatingView(rating: $rating)
                .padding(.bottom,5)
            
            Text("Your Review")
                .font(.custom(FONT_MEDIUM, size: 14))
                .padding(.vertical,2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            CustomTextView(fieldName: "Write your review here...", value: $reviewTextView, emptyErrorMessage: "Review can't be empty")
            
            
            HStack {
                Button(action: {
                    
                    if reviewTextView == "" {
                        return
                    }
                    
                    let vm = CourseRatingRequestModel(rate: rating,
                                                      description: reviewTextView,
                                                      course: courseId)
                    print("vm \(vm)")
                    courseDetailsViewModel.createReview(body: vm) { result in
                        if result {
                            self.showToast = true
                            self.reviewTextView = ""
                            courseDetailsViewModel.courseDetails(courseId: courseId)
                            hideKeyboard()
                        }
                    }
                    
                }) {
                    Text("Submit Review ")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                    
                    
                }
                
                .frame(height: 45)
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
    }
}


struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

//#Preview {
//    CourseHistoryDetailsView()
//}
