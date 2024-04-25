//
//  ForgetPasswordView.swift
//  kfump
//
//  Created by Mehedi Hasan on 16/4/24.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State var emailOrPhone: String = ""
    
    @State var isLoginButtonPress: Bool = false
    @State var isNavigateToRegistrationView: Bool = false
    @State var isNavigateToHomeScreen: Bool = false
    @State var isNavigateToOTPVerificationView: Bool = false
    @StateObject var authonicationViewModel = AuthenicationViewModel()
    
    @State private var isEnglishSelected = true
    
    @State private var showToast = false
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack {
                    
                        
                        Text(LocalizationSystem.shared.localizedStringForKey(key: FORGET_PASSWORD_KEY, comment: ""))
                            .font(.custom(FONT_BOLD, size: 32))
                            .padding(.top,50)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                        
                        Divider()
                            .frame(width: 56,height: 2)
                            .background(hexToColor(hex: "#D0B756"))
                        
                        Text("Enter the email address or phone number you use on KFUPM. We'll send you a link to reset your password.")
                            .font(.custom(FONT_BOLD, size: 15))
                            .padding(.vertical,20)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                        
                        
                        CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: EMAIL_OR_PHONE_KEY, comment: ""),
                                        value: $emailOrPhone,
                                        emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: EMAIL_CANT_BE_EMPTY_KEY, comment: ""),
                                        isButtonPress: isLoginButtonPress)
                        .padding(.top,20)
                        
                        
                       
                        
                        
                        Button(action: {
                            
                            isLoginButtonPress = true
                            
                            guard !emailOrPhone.isEmpty else {
                                return
                            }
                            
                            let vm = ForgetPasswordRequestModel(emailOrPhone: emailOrPhone)
                            
                            authonicationViewModel.forgetPassword(body: vm) { result in
                                
                                showToast.toggle()
                                
                                if result {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        
                                        isNavigateToOTPVerificationView = true
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                        }) {
                            Text(LocalizationSystem.shared.localizedStringForKey(key: RESET_PASSWORD_KEY, comment: ""))
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
                    .navigationDestination(isPresented: $isNavigateToOTPVerificationView, destination: { OTPView(emailAddress: emailOrPhone,source: "resetPassword").navigationBarBackButtonHidden(true) })
                    .navigationDestination(isPresented: $isNavigateToHomeScreen, destination: { Homescreen().navigationBarBackButtonHidden(true) })
                    .padding(20)
                    
                    
                    if authonicationViewModel.isLoading {
                        CustomProgressView()
                    }
                    ToastView(isPresented: $showToast, duration: 2.0) {
                        CustomTost(message: authonicationViewModel.dialogMessage)
                    }
                    
                }
                .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .onAppear {
                    print("isEnglishSelected => \(isEnglishSelected)")
                    print("LocalizationSystem.shared.getLanguage() => \(LocalizationSystem.shared.getLanguage())")
                    isEnglishSelected =  (LocalizationSystem.shared.getLanguage() == "en")
                    print("isEnglishSelected => \(isEnglishSelected)")
                }
                
                
            }
        }
        
    }
    
    
    var localizationView: some View {
        
        MyEqualWidthHStack {
            Button(action: {
                isEnglishSelected = true
                if LocalizationSystem.shared.getLanguage() == "ar" {
                    changeLanguage(code: "en")
                    isRTL = false
                }
                
            }) {
                Text("EN")
                    .frame(maxWidth: .infinity)
                    .fontWeight(isEnglishSelected ? .bold : .regular)
                    .padding(.vertical,10)
                    .padding(.horizontal,22)
                    .background(isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                    .foregroundColor(isEnglishSelected ? .white : .black)
                    .cornerRadius(25)
                
            }
            
            Button(action: {
                isEnglishSelected = false
                
                if LocalizationSystem.shared.getLanguage() == "en" {
                    changeLanguage(code: "ar")
                    isRTL = true
                }
                
                
            }) {
                Text("AR")
                    .frame(maxWidth: .infinity)
                    .fontWeight(!isEnglishSelected ? .bold : .regular)
                    .padding(.vertical,10)
                    .background(!isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                    .foregroundColor(!isEnglishSelected ? .white : .black)
                    .cornerRadius(25)
                    
            }
            
        }
        .frame(width: 150, height: 50)
        .background(hexToColor(hex: "#E4F4EA"))
        .cornerRadius(25)
    }
    
    
    func changeLanguage(code : String) {
        SetLanguage.shared.setLanguage(code: code)
    }
}

#Preview {
    ForgetPasswordView()
}
