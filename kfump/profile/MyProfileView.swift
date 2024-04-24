//
//  MyProfileView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct MyProfileView: View {
    
    @AppStorage(USER_UUID_D) var userUUID: String?
    
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
    
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    @State private var isShowUserTypeSheet = false
    @State private var isEnglishSelected = true
    
    @State private var showToast = false
    @State private var typeOfUserDropdownSelect = false
    
    @State private var selectedUserType = "1"
    
    
    
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
                                    value: $profileViewModel.firstName,
                                    emptyErrorMessage: "First name can't be empty",
                                    isButtonPress: isLoginButtonPress)
                    .redactShimmer(condition: profileViewModel.isLoading)
                    .padding(.top,40)
                    
                    
                    CustomTextField(fieldName: "Hasan",
                                    value: $profileViewModel.lastName,
                                    emptyErrorMessage: "Last name can't be empty",
                                    isButtonPress: isLoginButtonPress)
                    .redactShimmer(condition: profileViewModel.isLoading)
                    .padding(.top,10)
                    
                    CustomDisableTextView(fieldName: "johndoe787@gmail.com",
                                          value: $profileViewModel.emailAddress,
                                          emptyErrorMessage: "",
                                          isButtonPress: isLoginButtonPress)
                    .redactShimmer(condition: profileViewModel.isLoading)
                    .padding(.top,10)
                    .disabled(true)
                    
                    CustomDisableTextView(fieldName: "+966 12-345-6789",
                                          value: $profileViewModel.phoneNumber,
                                          emptyErrorMessage: "",
                                          isButtonPress: isLoginButtonPress)
                    .redactShimmer(condition: profileViewModel.isLoading)
                    .padding(.top,10)
                    .disabled(true)
                    
                    
                    
                    CustomTextField(fieldName: "Govt ID or Iqama no *",
                                    value: $profileViewModel.govtId,
                                    emptyErrorMessage: "Govt ID or Iqama no can't be empty",
                                    isButtonPress: isLoginButtonPress)
                    .redactShimmer(condition: profileViewModel.isLoading)
                    .padding(.top,10)
                    
//                    VStack {
//                        CustomDropDownView(typeOfUserDropdownSelect: typeOfUserDropdownSelect, fieldName: "Type of user",
//                                           value: $typeOfUser,
//                                           emptyErrorMessage: "")
//                        .padding(.top,10)
//                        .disabled(true)
//                    }
//                    .onTapGesture {
//                        self.isShowUserTypeSheet = true
//                        print("isShowUserTypeSheet")
//                    }
                    
                    Menu {
                        ForEach(profileViewModel.userTypeList) { item in
                            HStack {
                                Text(item.userType ?? "")
                                    .font(.headline)
                                Spacer()
                            }
                            .padding(20)
                            .onTapGesture {
                                self.typeOfUser = item.userType ?? ""
                                self.isShowUserTypeSheet = false
                            }
                        }
                    } label: {
                        CustomDropDownView(typeOfUserDropdownSelect: typeOfUserDropdownSelect, fieldName: "Type of user",
                                           value: $typeOfUser,
                                           emptyErrorMessage: "")
                        .frame(alignment: .leading)
                        .padding(.top,10)
                        .disabled(true)
                    }
                    .pickerStyle(MenuPickerStyle())

                    
                    
                    
                    
                    
                    Button(action: {
                        
                        isLoginButtonPress = true
                        
                        guard !profileViewModel.govtId.isEmpty,!profileViewModel.firstName.isEmpty,!profileViewModel.lastName.isEmpty else {
                            return
                        }
                        
                        
                        let vm = ProfileData(govtIdOrIqamaNo: profileViewModel.govtId,
                                             firstName: profileViewModel.firstName,
                                             lastName: profileViewModel.lastName,
                                             isCloseAccount: false,
                                             isDelete: false,
                                             userType: "")
                        
                        createParameter(vm: vm)
                        
                        
                    }) {
                        Text(LocalizationSystem.shared.localizedStringForKey(key: UPDATE_DETAILS_KEY, comment: ""))
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
                //                .navigationDestination(isPresented: $isNavigateToForgetPasswordView, destination: { ForgetPasswordView().navigationBarBackButtonHidden(true) })
                //                .navigationDestination(isPresented: $isNavigateToRegistrationView, destination: { RegistrationView().navigationBarBackButtonHidden(true) })
                //                .navigationDestination(isPresented: $isNavigateToHomeScreen, destination: { Homescreen().navigationBarBackButtonHidden(true) })
                .padding(20)
                .background(hexToColor(hex: "#FFFFFF"))
                
                
                if profileViewModel.isLoading {
                    CustomProgressView()
                }
                ToastView(isPresented: $showToast, duration: 2.0) {
                    CustomTost(message: profileViewModel.dialogMessage)
                }
                
            }
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .onAppear {
                print("User UUID => \(userUUID ?? "")")
                profileViewModel.getProfileData(userUUID: userUUID ?? "")
                profileViewModel.getUserTypeList()
            }
            .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: MY_PROFILE_KEY, comment: "")))
            
            
        }
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
        
        
    }
    
    
    func createParameter(vm : ProfileData) {
        
        let parameter : [String : Any] = [
            "first_name"       :  vm.firstName ?? "",
            "lastName"         :  vm.lastName ?? "",
            "govtIdOrIqamaNo"  :  vm.govtIdOrIqamaNo ?? "",
            "userType"         :  selectedUserType,
        ]
        
        profileViewModel.fetchDataForUpdateProfileData(uuId: userUUID ?? "", parameter: parameter)
        
        if profileViewModel.isSucess {
            
        }
    }
    
}

#Preview {
    MyProfileView()
}
