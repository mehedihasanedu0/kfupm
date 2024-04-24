//
//  ChangePasswordView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    
    @State var isChangePasswordButtonPress: Bool = false
    @State var isNavigateToRegistrationView: Bool = false
    @State var isNavigateToHomeScreen: Bool = false
    @State var isNavigateToOTPVerificationView: Bool = false
    @State var isNavigateToForgetPasswordView: Bool = false
    @StateObject var authenicationViewModel = AuthenicationViewModel()
    
    @State private var isEnglishSelected = true
    
    @State private var showToast = false
    
    @Environment(\.presentationMode) var presentationMode
    
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
                    

                    
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: CURRENT_PASSWORD_KEY, comment: ""),
                                          password: $oldPassword,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: CURRENT_PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isChangePasswordButtonPress)
                    .padding(.top,15)
                    
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: NEW_PASSWORD_KEY, comment: ""),
                                          password: $newPassword,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: NEW_PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isChangePasswordButtonPress)
                    .padding(.top,15)
                    
                    CustomSecureTextField(fieldName: LocalizationSystem.shared.localizedStringForKey(key: CONFIRM_PASSWORD_KEY, comment: ""),
                                          password: $confirmPassword,
                                          emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: CONFIRM_PASSWORD_CANT_BE_EMPTY_KEY, comment: ""),
                                          isButtonPress: isChangePasswordButtonPress)
                    .padding(.top,15)
                    
                    
                    

                    
                    
                    Button(action: {
                        
                        isChangePasswordButtonPress = true
                        
                        guard !oldPassword.isEmpty,!newPassword.isEmpty,!confirmPassword.isEmpty else {
                            return
                        }
                        
                        let vm = ChangePasswordRequestModel(oldPassword: oldPassword,
                                                            newPassword: newPassword,
                                                            confirmPassword: confirmPassword)
                        
                        authenicationViewModel.changePassword(userUUID: "vm",body: vm) { success in
                            showToast.toggle()
                            if success {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    presentationMode.wrappedValue.dismiss()
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
                    
         
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $isNavigateToForgetPasswordView, destination: { ForgetPasswordView().navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToRegistrationView, destination: { RegistrationView().navigationBarBackButtonHidden(true) })
                .navigationDestination(isPresented: $isNavigateToHomeScreen, destination: { Homescreen().navigationBarBackButtonHidden(true) })
                .padding(20)
//                .background(hexToColor(hex: "#FFFFFF"))
                
                
                
                
                if authenicationViewModel.isLoading {
                    CustomProgressView()
                }
                ToastView(isPresented: $showToast, duration: 2.0) {
                    CustomTost(message: authenicationViewModel.dialogMessage)
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
    ChangePasswordView()
}
