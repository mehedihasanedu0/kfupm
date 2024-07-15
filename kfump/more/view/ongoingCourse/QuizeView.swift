//
//  QuizeView.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/5/24.
//

import SwiftUI

struct QuizeView: View {
    
    @StateObject var viewModel = OngoingCourseDetailsViewModel()
    let title: String!
    @State var isButtonPress: Bool = false
    let selectedLectureId : Int!
    
    @Binding var nextPosition : Int
    @Environment(\.presentationMode) var presentationMode
    
    @State var quizeInfoList: [QuizQuestionAnswerInfo] = []
    
    @State private var showToast = false
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    
                    if viewModel.quizeList.count == 0 {
                        
                        NoDataFoundView(message: "No data found")
                    } else {
                        
                        ForEach(viewModel.quizeList.indices, id: \.self) { index in
                            SingleQuizeView(questionTitle: viewModel.quizeList[index].question ?? "", isButtonPress: isButtonPress, ans: $viewModel.answers[index])
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                        }
                        .padding(.top)
                        
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
            viewModel.getQuizeList(lectureId: selectedLectureId)
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: title))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
    }
    
    var submitButtonView: some View {
        
        HStack {
            
            Button(action: {
                isButtonPress = true
                
                quizeInfoList.removeAll()
                print("viewModel.surveyList.count \(viewModel.surveyList.count)")
                print("viewModel.surveyAnswers.count \(viewModel.surveyAnswers.count)")
                if viewModel.quizeList.count == viewModel.answers.count {
                    for (index, quize) in viewModel.quizeList.enumerated() {
                        if viewModel.answers[index].isEmpty {
                            return
                        }
                        quizeInfoList.append(QuizQuestionAnswerInfo(question_id: quize.id ?? 0, question_answer: viewModel.answers[index]))
                    }
                }
                let vm = QuizeSubmitRequestModel(lecture_id: selectedLectureId, quiz_question_answer_info: quizeInfoList)
                viewModel.quizeSubmit(body: vm) { result in
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
