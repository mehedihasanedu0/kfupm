//
//  MyProfileView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct MyProfileView: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var emailAddress: String = ""
    @State var phoneNumber: String = ""
    @State var govtId: String = ""
    @State var typeOfUser: String = ""
    @State var isLoginButtonPress: Bool = false
    @State var isNavigateToRegistrationView: Bool = false
    @State var isNavigateToHomeScreen: Bool = false
    @State var isNavigateToOTPVerificationView: Bool = false
    @State var isNavigateToForgetPasswordView: Bool = false
    @StateObject var authonicationViewModel = AuthenicationViewModel()
    
    @State private var isEnglishSelected = true
    
    @State private var showToast = false
    @State private var typeOfUserDropdownSelect = false
    
    
    
    var body: some View {
        
        
        ScrollView {
            ZStack {
                
                VStack {
                    
                    Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly")
                        .font(.custom("Open Sans", size: 14))
                        .padding(.top,20)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.center)
                    
                    
                    
                    CustomTextField(fieldName: "Mehedi",
                                    value: $firstName,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: USER_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .disabled(true)
                    .padding(.top,40)
                    
                    CustomTextField(fieldName: "Hasan",
                                    value: $lastName,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: USER_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,10) 
                    .disabled(true)
                    
                    CustomDisableTextView(fieldName: "johndoe787@gmail.com",
                                    value: $emailAddress,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: USER_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,10)  
                    .disabled(true)
                    
                    CustomDisableTextView(fieldName: "+966 12-345-6789",
                                    value: $phoneNumber,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: USER_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,10)
                    .disabled(true)
                    
                    
                    
                    CustomTextField(fieldName: "Govt ID or Iqama no *",
                                    value: $govtId,
                                    emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: USER_NAME_CANT_BE_EMPTY_KEY, comment: ""),
                                    isButtonPress: isLoginButtonPress)
                    .padding(.top,10)

                    
                    CustomDropDownView(typeOfUserDropdownSelect: typeOfUserDropdownSelect, fieldName: "Type of user",
                                       value: $typeOfUser,
                                       emptyErrorMessage: LocalizationSystem.shared.localizedStringForKey(key: USER_NAME_CANT_BE_EMPTY_KEY, comment: ""))
                    .padding(.top,10)
                    .disabled(true)
                    
                    
                    Button(action: {
                        
                        isLoginButtonPress = true
                        
                        guard !govtId.isEmpty else {
                            return
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
            .navigationBarItems(leading: CustomTitleBarItems(title: "My Profile"))


        }
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        

        
    }
    
}

#Preview {
    MyProfileView()
}
