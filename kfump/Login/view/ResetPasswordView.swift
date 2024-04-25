//
//  ResetPasswordView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct ResetPasswordView: View {
    
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isLoginButtonPress: Bool = false
    @State var isNavigateToRegistrationView: Bool = false
    @State var isNavigateToLogin: Bool = false
    @State var isNavigateToOTPVerificationView: Bool = false
    @State var isNavigateToForgetPasswordView: Bool = false
    @StateObject var authonicationViewModel = AuthenicationViewModel()
    
    @State private var isEnglishSelected = true
    
    @State private var showToast = false
    var token = ""
    

    
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
                    
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: CONFIRM_PASSWORD_KEY, comment: ""),
                                          password: $confirmPassword,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: CONFIRM_PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isLoginButtonPress)
                    .padding(.top,15)
                    
                    
                    

                    
                    
                    Button(action: {
                        
                        isLoginButtonPress = true
                        
                        guard !password.isEmpty,!confirmPassword.isEmpty else {
                            return
                        }
                        
                        let vm = ResetPasswordRequestModel(newPassword: password,
                                                           conformPassword: confirmPassword,
                                                           token: token)
                        print("resetPassword vm \(vm)")
                        authonicationViewModel.resetPassword(body: vm) { result in
                            
                            showToast.toggle()
                            
                            if result {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    
                                    isNavigateToLogin = true
                                }
                                
                            }
                            
                        }
                        
                        
                        
                    }) {
                        Text(LocalizationSystem.shared.localizedStringForKey(key: UPDATE_PASSWORD_KEY, comment: ""))
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
                .navigationDestination(isPresented: $isNavigateToLogin, destination: { LoginView().navigationBarBackButtonHidden(true) })

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
            .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: RESET_PASSWORD_KEY, comment: "")))


        }
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        

        
    }
    
}

#Preview {
    ResetPasswordView()
}
