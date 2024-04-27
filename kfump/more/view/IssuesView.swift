//
//  IssuesView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct IssuesView: View {
    
    
    @StateObject var moreViewModel = MoreViewModel()
    @State private var showToast = false
    
    var body: some View {
        ScrollView {
            
            ZStack {
                
                VStack {
                    
                    ForEach(moreViewModel.issueList,id: \.id) { item in
                        
                        SingleIssueView(singleIssue: item)
                        .padding()
                        .padding(.bottom,10)
                        .background(hexToColor(hex: "#F9F9F7"))
                        .cornerRadius(10)
                        
                        
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: YOUR_ISSUES_KEY , comment: "")))
                .onAppear {
                    moreViewModel.getReportedIssue()
                }
            }
            
            if moreViewModel.isLoading {
                CustomProgressView()
            }
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: moreViewModel.dialogMessage)
            }
            
            
        }
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
    }
    
}

#Preview {
    IssuesView()
}
