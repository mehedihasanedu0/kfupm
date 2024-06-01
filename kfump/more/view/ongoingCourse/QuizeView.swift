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
    
    var body: some View {
       
        ZStack {
            ScrollView {
                VStack {
                    ForEach(Array(viewModel.quizeList.enumerated()), id: \.1.id) { index, item in
                        SingleQuizeView(questionTitle: viewModel.quizeList[index].title, ans: $viewModel.answers[index])
                            .padding(.horizontal,20)
                            .padding(.vertical,5)

                    }
                }
            }
        }
        .onAppear {
            viewModel.getQuizeList(quiseId: 1)
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: title))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
 
    }
}

#Preview {
    QuizeView(title: "")
}
