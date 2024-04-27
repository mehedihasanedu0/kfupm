//
//  ContactUsView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct ContactUsView: View {
    
    
    @State var fullName: String = ""
    @State var eamil: String = ""
    @State var subject: String = ""
    @State var isLoginButtonPress: Bool = false
    
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
                    
                    CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: FULL_NAME_KEY, comment: ""),
                                    value: $fullName,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: FULL_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,40)
                    
                    CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: EMAIL_KEY, comment: ""),
                                    value: $eamil,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: EMAIL_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,15)        
                    
                    CustomTextView(fieldName: LocalizationSystem.shared.localizedStringForKey(key: SUBJECT_KEY, comment: ""),
                                    value: $subject,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: SUBJECT_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,15)
                    
                    
                    Button(action: {
                        
                        isLoginButtonPress = true
                        
//                        guard !userName.isEmpty,!password.isEmpty else {
//                            return
//                        }
//                        
//                        let vm = SignInModel(username: userName,
//                                             password: password)
//                        
//                        authonicationViewModel.signIn(body: vm) { result in
//                            
//                            showToast.toggle()
//                            
//                            if result {
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                    
//                                    presentationMode.wrappedValue.dismiss()
//                                }
//                                
//                            }
//                            
//                        }
                        
                        
                        
                    }) {
                        Text(LocalizationSystem.shared.localizedStringForKey(key: SEND_KEY, comment: ""))
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
                .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: CONTACT_US_KEY , comment: "")))
            }
            .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        }

    }
}

#Preview {
    ContactUsView()
}
