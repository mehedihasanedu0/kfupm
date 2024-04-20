//
//  ChangePasswordView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @State var userName: String = ""
    @State var password: String = ""
    @State var isLoginButtonPress: Bool = false
    @State var isNavigateToRegistrationView: Bool = false
    @State var isNavigateToHomeScreen: Bool = false
    @State var isNavigateToOTPVerificationView: Bool = false
    @State var isNavigateToForgetPasswordView: Bool = false
    @StateObject var authonicationViewModel = AuthenicationViewModel()
    
    @State private var isEnglishSelected = true
    
    @State private var showToast = false
    
    
    var body: some View {
        
        
        ScrollView {
            ZStack {
                
                VStack {
                    
                    Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly")
                        .font(.custom("Open Sans", size: 14))
                        .padding(.top,20)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                        .frame(width: 56,height: 2)
                        .background(hexToColor(hex: "#D0B756"))
                    

                    
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_KEY, comment: ""),
                                          password: $password,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isLoginButtonPress)
                    .padding(.top,15)
                    
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_KEY, comment: ""),
                                          password: $password,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isLoginButtonPress)
                    .padding(.top,15)                    
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_KEY, comment: ""),
                                          password: $password,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isLoginButtonPress)
                    .padding(.top,15)
                    
                    
                    

                    
                    
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
                    
         
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $isNavigateToForgetPasswordView, destination: { ForgetPasswordView().navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToRegistrationView, destination: { RegistrationView().navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToHomeScreen, destination: { Homescreen().navigationBarBackButtonHidden(true) })
                .padding(20)
                .background(hexToColor(hex: "#FFFFFF"))
                
                
                if authonicationViewModel.isLoading {
                    CustomProgressView()
                }
                ToastView(isPresented: $showToast, duration: 2.0) {
                    CustomTost(message: authonicationViewModel.dialogMessage)
                }
                
            }
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .onAppear {
            }
            .navigationBarItems(leading: CustomTitleBarItems(title: "Rest Password"))


        }
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        

        
    }
    
}

#Preview {
    ChangePasswordView()
}
