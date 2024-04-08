//
//  LoginView.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/3/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var userName: String = ""
    @State var password: String = ""
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
                        
                        HStack {
                            
                            Button(action: {
                                self.isNavigateToHomeScreen = true
                            }) {
                                Text(LocalizationSystem.shared.localizedStringForKey(key: SIGN_UP_LATER_KEY, comment: ""))
                                    .padding(.vertical,10)
                                    .font(.custom(FONT_SEMIBOLD, size: 14))
                                    .foregroundColor(hexToColor(hex: "#007D40"))
                                
                            }
                            
                            
                            Spacer()
                            
                            localizationView
                        }
                        
                        Text(LocalizationSystem.shared.localizedStringForKey(key: WELCOME_TO_CONTINUE_EDUCATION_PROGRAM_KEY, comment: ""))
                            .font(.custom("Open Sans", size: 32))
                            .padding(.top,20)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                        
                        Divider()
                            .frame(width: 56,height: 2)
                            .background(hexToColor(hex: "#D0B756"))
                        
                        CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: EMAIL_OR_PHONE_KEY, comment: ""),
                                        value: $userName,
                                        emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: USER_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                        isButtonPress: isLoginButtonPress)
                        .padding(.top,40)
                        
                        
                        CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_KEY, comment: ""),
                                              password: $password,
                                              emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                              isButtonPress: isLoginButtonPress)
                        .padding(.top,15)
                        
                        
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                self.isNavigateToOTPVerificationView = true
                            }) {
                                Text(LocalizationSystem.shared.localizedStringForKey(key: FORGET_PASSWORD_KEY, comment: ""))
                                    .padding(.vertical,10)
                                    .font(.custom(FONT_REGULAR, size: 14))
                                    .foregroundColor(hexToColor(hex: "#7C7C7C"))
                                
                            }
                            
                        }
                        .navigationDestination(isPresented: $isNavigateToOTPVerificationView, destination: { OTPView(emailAddress: userName).navigationBarBackButtonHidden(true) })
                        
                        
                        Button(action: {
                            
                            isLoginButtonPress = true
                            
                            guard !userName.isEmpty,!password.isEmpty else {
                                return
                            }
                            
                            let vm = SignInModel(username: userName,
                                                 password: password)
                            
                            authonicationViewModel.signIn(body: vm) { result in
                                
                                showToast.toggle()
                                
                                if result {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        
                                        isNavigateToHomeScreen = true
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                        }) {
                            Text(LocalizationSystem.shared.localizedStringForKey(key: LOGIN_KEY, comment: ""))
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
                        
                        HStack {
                            Divider()
                                .frame(maxWidth: .infinity)
                                .frame(height: 2)
                                .padding(.horizontal,5)
                                .background(hexToColor(hex: "#E5E5D9"))
                            
                            Text("Or")
                            
                            Divider()
                                .frame(maxWidth: .infinity)
                                .frame(height: 2)
                                .padding(.horizontal,5)
                                .background(hexToColor(hex: "#E5E5D9"))
                        }
                        .padding(.top,20)
                        
                        
                        Button(action: {
                            print("userName \(userName)")
                            print("password \(password)")
                            
                        }) {
                            Text(LocalizationSystem.shared.localizedStringForKey(key: CONTINUE_WITH_KFU_ID_KEY, comment: ""))
                                .padding(.vertical,10)
                                .font(.custom(FONT_BOLD, size: 16))
                                .foregroundColor(.black)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding(.vertical,20)
                                .foregroundColor(.white)
                            
                        }
                        
                        .frame(height: 56)
                        .cornerRadius(10.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 0.3)
                        }
                        .padding(.top,20)
                        
                        HStack {
                            Text(LocalizationSystem.shared.localizedStringForKey(key: DONT_HAVE_AN_ACCOUNT_KEY, comment: ""))
                                .font(.custom(FONT_REGULAR, size: 14))
                            
                            Button(action: {
                                self.isNavigateToRegistrationView = true
                                
                            }) {
                                Text(LocalizationSystem.shared.localizedStringForKey(key: REGISTRATION_KEY, comment: ""))
                                    .font(.custom(FONT_REGULAR, size: 14))
                                    .bold()
                                    .foregroundColor(hexToColor(hex: "#007D40"))
                                
                            }
                            
                        }
                        .padding(.top,20)
                        
                    }
                    .navigationDestination(isPresented: $isNavigateToRegistrationView, destination: { RegistrationView().navigationBarBackButtonHidden(true) })
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

//#Preview {
//    LoginView()
//}


