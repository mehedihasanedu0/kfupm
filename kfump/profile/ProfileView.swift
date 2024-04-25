//
//  ProfileView.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage(Keys.IS_LOGIN_D.rawValue) var isLogin: Bool?
    @AppStorage(Keys.USER_UUID_D.rawValue) var userUUID: String?
    @AppStorage(Keys.USER_NAME.rawValue) var userName: String?
    @AppStorage(Keys.USER_PROFILE.rawValue) var userImageBase64: String?
    
    @State private var isEnglishSelected = true
    @State private var isNavigateToResetPasswordView = false
    @State private var isNavigateToMyProfileView = false
    @State private var isShowingConfirmationView = false
    @State private var isNavigateToCloseAccountView = false
    @State private var isNavigateToLoginView = false
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    
    var body: some View {
        
        
        ZStack {
            
            VStack {
                
                if let image = decodeBase64ToImage(userImageBase64 ?? "") {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 130,height: 130)
                        .cornerRadius(65)
                        .padding(.top,50)
                } else {
                    Image("nature")
                        .resizable()
                        .frame(width: 130,height: 130)
                        .cornerRadius(65)
                        .padding(.top,50)
                }
                

                
                
                Text(userName ?? "")
                    .font(.custom(FONT_SEMIBOLD, size: 20))
                    .padding()
                
                VStack {
                    
                    ForEach(profileItemList) { item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .frame(width: 25,height: 25)
                            
                            Text(LocalizationSystem.shared.getLanguage() == "ar" ? item.nameAr : item.nameEn)
                                .font(.headline)
                            
                            Spacer()
                            
                            if item.id == 4 {
                                localizationView
                            }
                        }
                        .onTapGesture {
                            if isLogin ?? false {
                                handleAction(for: item)
                            }
                            
                        }
                        .padding()
                        .background(Color.white)
                        if item.id != profileItemList.last?.id {
                            Divider().background(Color.clear)
                                .padding(.horizontal,10)
                        }
                    }
                    
                    
                }
                
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(20)
                .padding()
                
                Spacer()
            }
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .onAppear {
                print("isEnglishSelected => \(isEnglishSelected)")
                print("LocalizationSystem.shared.getLanguage() => \(LocalizationSystem.shared.getLanguage())")
                isEnglishSelected =  (LocalizationSystem.shared.getLanguage() == "en")
                print("isEnglishSelected => \(isEnglishSelected)")
            }
            .frame(maxWidth: .infinity)
            .background(hexToColor(hex: "#F9F9F7"))
            .navigationDestination(isPresented: $isNavigateToLoginView, destination: { LoginView().navigationBarBackButtonHidden(true) })
            .navigationDestination(isPresented: $isNavigateToResetPasswordView, destination: { ChangePasswordView().navigationBarBackButtonHidden(true) })
            .navigationDestination(isPresented: $isNavigateToMyProfileView, destination: { MyProfileView().navigationBarBackButtonHidden(true) })     
            .navigationDestination(isPresented: $isNavigateToCloseAccountView, destination: { CloseAccountView().navigationBarBackButtonHidden(true) })
            
            
            
            
            if isShowingConfirmationView {
                
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowingConfirmationView = false
                    }
                
                CustomLogoutConfirmationView(
                    title: "Confirmation",
                    message: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly",
                    onConfirm: {
                        // Handle Yes action
                        isShowingConfirmationView = false
                        isNavigateToLoginView = true
                        UserDefaults.standard.resetKeys()
                        
                    },
                    onCancel: {
                        // Handle No action
                        isShowingConfirmationView = false
                    }
                )
                .transition(.scale)
            }
        }
        .onAppear {
            profileViewModel.getProfileData(userUUID: userUUID ?? "") { result in
                if result {
                    profileViewModel.fetchImageData(profileViewModel.imageUrl)
                }
            }
        }
        
    }
    
    
    
    
    func handleAction(for item: ProfileItem) {
        switch item.id {
        case 1:
            isNavigateToMyProfileView = true
        case 2:
            isNavigateToResetPasswordView = true
        case 3:
            // Payment History
            print("Payment History selected")
        case 4:
            // Change Language
            print("Language setting selected")
        case 5:
            // Log out
            isShowingConfirmationView.toggle()
        case 6:
            // Close Account
            isNavigateToCloseAccountView = true
        default:
            break
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
                    .font(.custom(FONT_MEDIUM, size: 15))
                    .frame(maxWidth: .infinity)
                    .fontWeight(isEnglishSelected ? .bold : .regular)
                    .padding(.vertical,3)
                    .padding(.horizontal,4)
                    .background(isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                    .foregroundColor(isEnglishSelected ? .white : .black)
                    .cornerRadius(15)
                
            }
            
            Button(action: {
                isEnglishSelected = false
                
                if LocalizationSystem.shared.getLanguage() == "en" {
                    changeLanguage(code: "ar")
                    isRTL = true
                }
                
                
            }) {
                Text("AR")
                    .font(.custom(FONT_MEDIUM, size: 15))
                    .frame(maxWidth: .infinity)
                    .fontWeight(!isEnglishSelected ? .bold : .regular)
                    .padding(.vertical,4)
                    .background(!isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                    .foregroundColor(!isEnglishSelected ? .white : .black)
                    .cornerRadius(15)
                
            }
            
        }
        .frame(width: 70, height: 30)
        .background(hexToColor(hex: "#E4F4EA"))
        .cornerRadius(25)
    }
    
    
    func changeLanguage(code : String) {
        SetLanguage.shared.setLanguage(code: code)
    }
    
}


#Preview {
    ProfileView()
}
