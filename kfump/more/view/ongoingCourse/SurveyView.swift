//
//  SurveyView.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/7/24.
//

import SwiftUI

struct SurveyView: View {
    
    @StateObject var viewModel = OngoingCourseDetailsViewModel()
    let title: String!
    @State var isButtonPress: Bool = false
    let selectedCourseId : Int!
    let selectedsurveyCategoryId : Int!
    
    @State var surveyInfoList: [SurveySubmitInfo] = []
    
    @Binding var nextPosition : Int
    @Environment(\.presentationMode) var presentationMode
    @State private var showToast = false
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    
                    if viewModel.surveyList.count == 0 {
                        
                        NoDataFoundView(message: "No data found")
                    } else {
                        
                        ForEach(viewModel.surveyList.indices, id: \.self) { index in
                            SingleQuizeView(questionTitle: viewModel.surveyList[index].surveyQuestion ?? "", isButtonPress: isButtonPress, ans: $viewModel.surveyAnswers[index])
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                        }
                        .padding(.top,15)
                        
                        submitButtonView
                            .padding(.top)
                            .padding(.bottom)
                    }

                }
            }
            
            if viewModel.isLoading {
                CustomProgressView()
            }
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: viewModel.dialogMessage)
            }
            
        }
        .onAppear {
            viewModel.getServeyList(courseId: selectedCourseId, surveyCategoryId: selectedsurveyCategoryId)
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: title))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
    }
    
    var submitButtonView: some View {
        
        HStack {
            
            Button(action: {
                isButtonPress = true
                surveyInfoList.removeAll()
                print("viewModel.surveyList.count \(viewModel.surveyList.count)")
                print("viewModel.surveyAnswers.count \(viewModel.surveyAnswers.count)")
                if viewModel.surveyList.count == viewModel.surveyAnswers.count {
                    for (index, survey) in viewModel.surveyList.enumerated() {
                        if viewModel.surveyAnswers[index].isEmpty {
                            return
                        }
                        surveyInfoList.append(SurveySubmitInfo(survey_id: survey.id ?? 0, survey_answer: viewModel.surveyAnswers[index]))
                    }
                    print("surveyInfoList \(surveyInfoList)")
                }
                let vm = SurveyAnswerSubmitModel(course_id: selectedCourseId, survey_submit_info: surveyInfoList)
                viewModel.surveySubmit(body: vm) { result in
                    showToast.toggle()
                    if result {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                }
            }) {
                HStack {
                    Text("Submit")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(hexToColor(hex: "#007D40"))
     
                }
                
            }
            .frame(width: 100, height: 45)
            .background(.white)
            .cornerRadius(22)
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
            }
            .padding(.leading,25)
            
            Spacer()
            
            HStack {
                Text("Next")
                    .font(.custom(FONT_SEMIBOLD, size: 16))
                    .foregroundColor(hexToColor(hex: "#007D40"))
                
                Image(isRTL ? "ic_next_ar"  : "ic_next")
                    .resizable()
                    .frame(width: 20,height: 20)
            }
            .onTapGesture {
                nextPosition = nextPosition + 1
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.trailing,25)
        }
        .padding(.top)
    }
}

//#Preview {
//    QuizeView(title: "")
//}
