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
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.quizeList.indices, id: \.self) { index in
                        SingleQuizeView(questionTitle: viewModel.quizeList[index].title ?? "", isButtonPress: isButtonPress, ans: $viewModel.answers[index])
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                    }
                    
                    submitButtonView
                        .padding(.top)
                        .padding(.bottom)
                }
            }
            
        }
        .onAppear {
            viewModel.getQuizeList(quiseId: selectedLectureId)
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: title))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
    }
    
    var submitButtonView: some View {
        
        HStack {
            
            Button(action: {
                isButtonPress = true
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
            .padding(.trailing,25)
        }
        .padding(.top)
    }
}

//#Preview {
//    QuizeView(title: "")
//}
