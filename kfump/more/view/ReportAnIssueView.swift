//
//  ReportAnIssueView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct ReportAnIssueView: View {
    
    @State var subject: String = ""
    @State var details: String = ""
    @State var isLoginButtonPress: Bool = false
    
    @State var isNavigateToIssuesView: Bool = false
    @State private var showToast = false
    
    @StateObject var moreViewModel = MoreViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView {
            ZStack {
                
                VStack {
                    
                    Text("Lorem ipsum dolor sit amet consectetur. Tortor sollicitudin sem tortor scelerisque Feugiat eget pretium ipsum")
                        .font(.custom(FONT_LIGHT, size: 16))
                        .padding(.vertical,5)
                        .frame(maxWidth: .infinity, alignment: .leading) 
                        .padding(.top,15)
                    
                    Text(LocalizationSystem.shared.localizedStringForKey(key: TRACK_YOUR_SUBMITTED_ISSUE_KEY    , comment: ""))
                        .font(.custom(FONT_LIGHT, size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(hexToColor(hex: "#D0B756"))
                        .underline()
                        .onTapGesture {
                            isNavigateToIssuesView = true
                        }
                    
                    Text(LocalizationSystem.shared.localizedStringForKey(key: SUBMIT_ISSUE_KEY    , comment: ""))
                        .font(.custom(FONT_BOLD, size: 16))
                        .padding(.vertical,5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: SUBJECT_KEY, comment: ""),
                                    value: $subject,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: SUBJECT_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top)

                    
                    CustomTextView(fieldName: LocalizationSystem.shared.localizedStringForKey(key: DETAILS_KEY, comment: ""),
                                    value: $details,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: DETAILS_CANT_BE_EMPTY_KEY	, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,15)
                    
                    
                    Button(action: {
                        
                        isLoginButtonPress = true
                        
                        guard !subject.isEmpty,!details.isEmpty else {
                            return
                        }

                        let vm = ReportedAnIssueRequestModel(subject: subject,
                                                             description: details)

                        moreViewModel.createReportedIssue(body: vm) { result in

                            showToast.toggle()

                            if result {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    subject.removeAll()
                                    details.removeAll()
                                    isLoginButtonPress = false
                                    isNavigateToIssuesView = true
                                }

                            }

                        }
                        
                        
                        
                    }) {
                        Text(LocalizationSystem.shared.localizedStringForKey(key: SUBMIT_KEY, comment: ""))
                            .padding(.vertical,10)
                            .font(.custom(FONT_BOLD, size: 16))
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,20)
                            .foregroundColor(.white)
                        
                    }
                    
                    .background(hexToColor(hex: "#007D40"))
                    .frame(height: 56)
                    .cornerRadius(10.0)
                    .padding(.top,20)
                    
                }
                .padding(.horizontal)
                .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: REPORT_AN_ISSUE_KEY , comment: "")))
                
                if moreViewModel.isLoading {
                    CustomProgressView()
                }
                ToastView(isPresented: $showToast, duration: 2.0) {
                    CustomTost(message: moreViewModel.dialogMessage)
                }
                
            }
            .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationDestination(isPresented: $isNavigateToIssuesView, destination: { IssuesView().navigationBarBackButtonHidden(true) })

    }
}

//#Preview {
//    ReportAnIssueView()
//}
