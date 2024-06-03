//
//  CloseAccountView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct CloseAccountView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var isShowingConfirmationView = false
    @State private var isNavigateToLoginView = false
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly")
                    .font(.custom("Open Sans", size: 14))
                    .padding(.top,20)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                
                
                Button(action: {
                    
                    
                    isShowingConfirmationView = true
                }) {
                    Text(LocalizationSystem.shared.localizedStringForKey(key: CLOSE_YOUR_ACCOUNT_KEY, comment: ""))
                        .padding(.vertical,10)
                        .font(.custom(FONT_BOLD, size: 16))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,20)
                        .foregroundColor(.white)
                    
                }
                
                .background(hexToColor(hex: "#DA2D21"))
                .frame(height: 56)
                .cornerRadius(10.0)
                .padding(.top,20)
                
     
                Spacer()
            }
            .padding(.horizontal)
            
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
                        let vm = CloseAccountRequestModel(isCloseAccount: true)
                        profileViewModel.colseAccount(body: vm) { result in
                            showToast.toggle()
                            if result {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    UserDefaults.standard.resetKeys()
                                    isNavigateToLoginView = true
                                }
                                
                            }
                            
                        }
                        isShowingConfirmationView = false
                    },
                    onCancel: {
                        // Handle No action
                        isShowingConfirmationView = false
                    }
                )
                .transition(.scale)
            }
            
            
            if profileViewModel.isLoadingCloseView {
                CustomProgressView()
            }
            
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: profileViewModel.dialogMessage)
            }
            
            
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .onAppear {
        }
        .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: CLOSE_ACCOUNT_KEY, comment: "")))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .navigationDestination(isPresented: $isNavigateToLoginView, destination: { LoginView().navigationBarBackButtonHidden(true) })
    }
}

//#Preview {
//    CloseAccountView()
//}
