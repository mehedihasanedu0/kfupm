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
    @State var phoneNumber: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isRegistrationButtonPress: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showToast = false
    @State var toastMessage: String = ""
    
    @StateObject var authonicationViewModel = AuthenicationViewModel()
    @State var isNavigateToOTPView: Bool = false
    
    
    var body: some View {
        ScrollView {
            
            ZStack {
                
                VStack {
                    
                    HStack {
                        Button(action: {
                            
                        }) {
                            Text("Sign Up Later")
                                .padding(.vertical,10)
                                .font(.custom(FONT_SEMIBOLD, size: 14))
                                .foregroundColor(hexToColor(hex: "#007D40"))
                            
                        }
                        Spacer()
                    }
                    
                    Text("Sign UP")
                        .font(.custom(FONT_BOLD, size: 32))
                        .padding(.top,20)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                        .frame(width: 56,height: 2)
                        .background(hexToColor(hex: "#D0B756"))
                    
                    CustomTextField(fieldName: "Full Name *",
                                    value: $fullName,
                                    emptyErrorMessage: "Full Name Can't be empty",
                                    isButtonPress: isRegistrationButtonPress)
                    .padding(.top,40)
                    
                    CustomTextField(fieldName: "Email *",
                                    value: $email,
                                    emptyErrorMessage: "Email Can't be empty",
                                    isButtonPress: isRegistrationButtonPress)
                    .keyboardType(.emailAddress)
                    .padding(.top,15)
                    
                    CustomTextField(fieldName: "Phone Number *",
                                    value: $phoneNumber,
                                    emptyErrorMessage: "Email Can't be empty",
                                    isButtonPress: isRegistrationButtonPress)
                    .keyboardType(.phonePad)
                    .padding(.top,15)
                    
                    
                    CustomSecureTextField(fieldName: "Password",
                                          password: $password,
                                          emptyErrorMessage: "Password can't be empty",
                                          isButtonPress: isRegistrationButtonPress)
                    .padding(.top,15)
                    
                    CustomSecureTextField(fieldName: "Confirm Password",
                                          password: $confirmPassword,
                                          emptyErrorMessage: "Confirm Password can't be empty",
                                          isButtonPress: isRegistrationButtonPress)
                    .padding(.top,15)
                    
                    
         
                    
                    Button(action: {
                        
                        isRegistrationButtonPress = true
                        guard !fullName.isEmpty,!phoneNumber.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
                            return
                        }
                        
                        registration()
                    
                        
                    }) {
                        Text("Registration")
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
                        Text("Already have an account?")
                            .font(.custom(FONT_REGULAR, size: 14))
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Text("Log in")
                                .font(.custom(FONT_REGULAR, size: 14))
                                .bold()
                                .foregroundColor(hexToColor(hex: "#007D40"))
                            
                        }
                        
                    }
                    .padding(.top,20)
                    
                }
                .padding(20)
                .navigationDestination(isPresented: $isNavigateToOTPView, destination: { OTPView(emailAddress: email).navigationBarBackButtonHidden(true) })
                

                
                if authonicationViewModel.isLoading {
                    CustomProgressView()
                }
                
                ToastView(isPresented: $showToast, duration: 2.0) {
                    CustomTost(message: authonicationViewModel.dialogMessage)
                }
            }
            
            
        }
    }
    
    func registration() {
        
        let vm = SignUpModel(fullName: fullName,
                             phoneNumber: phoneNumber,
                             email: email,
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
