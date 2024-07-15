//
//  RegistrationView.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/3/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var eqama: String = ""
    @State var phoneNumber: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isRegistrationButtonPress: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showToast = false
    @State var toastMessage: String = ""
    
    @StateObject var authonicationViewModel = AuthenicationViewModel()
    @State var isNavigateToOTPView: Bool = false
    @State var isNavigateToHomeScreen: Bool = false
    @State private var isEnglishSelected = true
    
    
    var body: some View {
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
                    
                    Text(LocalizationSystem.shared.localizedStringForKey(key: SIGN_UP_KEY, comment: ""))
                        .font(.custom(FONT_REGULAR, size: 32))
                        .padding(.top,20)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                        .frame(width: 56,height: 2)
                        .background(hexToColor(hex: "#D0B756"))
                    
                    CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: FULL_NAME_KEY, comment: ""),
                                    value: $fullName,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: FULL_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isRegistrationButtonPress)
                    .padding(.top,40)
                    
                    CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: EMAIL_KEY, comment: ""),
                                    value: $email,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: EMAIL_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isRegistrationButtonPress)
                    .keyboardType(.emailAddress)
                    .padding(.top,15)
                    
                    CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: PHONE_NUMBER_KEY, comment: ""),
                                    value: $phoneNumber,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: PHONE_NUMBER_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isRegistrationButtonPress)
                    .keyboardType(.numberPad)
                    .padding(.top,15)
                    
                    CustomTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: EQAMA_KEY, comment: ""),
                                    value: $eqama,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: EQAMA_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isRegistrationButtonPress)
                    .padding(.top,15)
                    
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_KEY, comment: ""),
                                          password: $password,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isRegistrationButtonPress)
                    .padding(.top,15)
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: CONFIRM_PASSWORD_KEY, comment: ""),
                                          password: $confirmPassword,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: CONFIRM_PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isRegistrationButtonPress)
                    .padding(.top,15)
                    
                    
         
                    
                    Button(action: {
                        
                        isRegistrationButtonPress = true
                        guard !fullName.isEmpty,!phoneNumber.isEmpty, !email.isEmpty, !eqama.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
                            return
                        }
                        
                        registration()
                    
                        
                    }) {
                        Text(LocalizationSystem.shared.localizedStringForKey(key: REGISTRATION_KEY, comment: ""))
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
                        Text(LocalizationSystem.shared.localizedStringForKey(key: ALREADY_HAVE_AN_ACCOUNT_KEY, comment: ""))
                            .font(.custom(FONT_REGULAR, size: 14))
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Text(LocalizationSystem.shared.localizedStringForKey(key: REGISTER_LOGIN_KEY, comment: ""))
                                .font(.custom(FONT_REGULAR, size: 14))
                                .bold()
                                .foregroundColor(hexToColor(hex: "#007D40"))
                            
                        }
                        
                    }
                    .padding(.top,20)
                    
                }
                .padding(20)
                .navigationDestination(isPresented: $isNavigateToOTPView, destination: { OTPView(emailAddress: email, source: "registration").navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToHomeScreen, destination: { Homescreen().navigationBarBackButtonHidden(true) })
                

                
                if authonicationViewModel.isLoading {
                    CustomProgressView()
                }
                
                ToastView(isPresented: $showToast, duration: 2.0) {
                    CustomTost(message: authonicationViewModel.dialogMessage)
                }
            }.environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .onAppear {
                    isEnglishSelected =  (LocalizationSystem.shared.getLanguage() == "en")
                }
            
            
        }
    }
    
    var localizationView: some View {
        
        VStack {
            
            HStack(spacing: 0) {
                
                VStack {
                    Text("EN")
                        .font(.custom(FONT_MEDIUM, size: 14))
                        .padding(.vertical,6)
                        .frame(width: isEnglishSelected ? 52 : 37)
                        .background(isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                        .foregroundColor(isEnglishSelected ? .white : .black)
                    
                }
                .onTapGesture {
                    isEnglishSelected = true
                    if LocalizationSystem.shared.getLanguage() == "ar" {
                        changeLanguage(code: "en")
                        isRTL = false
                    }
                }
                .cornerRadius(25)
                .padding(.trailing,3)
                
                
                VStack {
                    Text("AR")
                        .padding(.vertical,5)
                        .font(.custom(FONT_MEDIUM, size: 14))
                        .frame(width: !isEnglishSelected ? 52 : 37)
                        .background(!isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                        .foregroundColor(!isEnglishSelected ? .white : .black)
                        .onTapGesture {
                            isEnglishSelected = false
                            
                            if LocalizationSystem.shared.getLanguage() == "en" {
                                changeLanguage(code: "ar")
                                isRTL = true
                            }
                        }
                }
                .cornerRadius(25)
                .padding(.leading,3)
                
                
                
            }
        }
        .frame(width: 103, height: 36)
        .background(hexToColor(hex: "#E4F4EA"))
        .cornerRadius(25)
        
    }
    
    
    func changeLanguage(code : String) {
        SetLanguage.shared.setLanguage(code: code)
    }
    
    func registration() {
        
        let vm = SignUpModel(fullName: fullName,
                             phoneNumber: phoneNumber,
                             email: email,
                             govtIdOrIqamaNo: eqama,
                             password: password,
                             confirmPassword: confirmPassword)
        
        authonicationViewModel.signUp(body: vm) { result in
            showToast.toggle()
            if result {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isNavigateToOTPView = true
                }
                
            }
        }
        
    }
}

//#Preview {
//    RegistrationView()
//}
