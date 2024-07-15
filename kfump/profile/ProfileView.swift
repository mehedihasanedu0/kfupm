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
    @State private var isNavigateToPaymentHistoryView = false
    
    @State private var selectedImage = UIImage()
    @State private var showSheet = false
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    @Binding var selectedTabIndex: Int
    @Binding var changeLanguage: String
    
    
    var body: some View {
        
        
        ZStack {
            
            VStack {
                
                if let image = decodeBase64ToImage(userImageBase64 ?? "") {
                    if #available(iOS 17.0, *) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 130,height: 130)
                            .cornerRadius(65)
                            .padding(.top,50)
                            .onTapGesture {
                                showSheet = true
                            }
                            .sheet(isPresented: $showSheet) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage)
                            }
//                            .sheet(isPresented: $showSheet) {
//                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage)
//                            }
                            .onChange(of : selectedImage) {
                                userImageBase64 = encodeImageToBase64String(selectedImage)
                                uploadProfileImage()
                            }
                        
                    }
                    
                } else  {
                    if #available(iOS 17.0, *) {
                        Image("demo_profile")
                            .resizable()
                            .frame(width: 130,height: 130)
                            .background(.gray).cornerRadius(65)
                            .padding(.top,50)
                            .onTapGesture {
                                showSheet = true
                            }
                            .sheet(isPresented: $showSheet) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage)
                            }
                            .onChange(of : selectedImage) {
                                userImageBase64 = encodeImageToBase64String(selectedImage)
                                uploadProfileImage()
                            }
                    }

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
            .navigationDestination(isPresented: $isNavigateToPaymentHistoryView, destination: { PaymentHistoryView().navigationBarBackButtonHidden(true) })
            
            
            
            
            if isShowingConfirmationView {
                
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowingConfirmationView = false
                    }
                
                CustomConfirmationView(
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
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
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
            isNavigateToPaymentHistoryView = true
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
    
    
    
    func uploadProfileImage() {
        let parameter : [String : Any] = [
            "image"          :  selectedImage
        ]

        print("parameter \(parameter)")
        profileViewModel.fetchDataForUpdateProfileData(uuId: userUUID ?? "", parameter: parameter)
    }
    
    var localizationView: some View {
        
        VStack {
            
            HStack(spacing: 0) {
                
                VStack {
                    Text("EN")
                        .font(.custom(FONT_MEDIUM, size: 12))
                        .padding(.vertical,5)
                        .frame(width: isEnglishSelected ? 36 : 30)
                        .background(isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                        .foregroundColor(isEnglishSelected ? .white : .black)
                    
                }
                .onTapGesture {
                    isEnglishSelected = true
                    if LocalizationSystem.shared.getLanguage() == "ar" {
                        changeLanguage(code: "en")
                        changeLanguage = "en"
                        isRTL = false
                    }
                }
                .cornerRadius(25)
                .padding(.trailing,3)
                
                
                VStack {
                    Text("AR")
                        .padding(.vertical,4)
                        .font(.custom(FONT_MEDIUM, size: 12))
                        .frame(width: !isEnglishSelected ? 36 : 30)
                        .background(!isEnglishSelected ? hexToColor(hex: "#41B06B") : .clear)
                        .foregroundColor(!isEnglishSelected ? .white : .black)
                        .onTapGesture {
                            isEnglishSelected = false
                            
                            if LocalizationSystem.shared.getLanguage() == "en" {
                                changeLanguage(code: "ar")
                                changeLanguage = "ar"
                                isRTL = true
                            }
                        }
                }
                .cornerRadius(25)
                .padding(.leading,1)
                
                
                
            }
        }
        .frame(width: 75, height: 30)
        .background(hexToColor(hex: "#E4F4EA"))
        .cornerRadius(25)
        
    }
    
    
    func changeLanguage(code : String) {
        selectedTabIndex = 2
        SetLanguage.shared.setLanguage(code: code)
    }
    
}


//#Preview {
//    ProfileView()
//}
