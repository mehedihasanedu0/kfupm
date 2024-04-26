//
//  SplashView.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/4/24.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isNavigateToLoginView = false
    @State private var isNavigateToHomeView = false
    @AppStorage(Keys.IS_LOGIN_D.rawValue) var loginStatus: Bool?
    
    var body: some View {
        
        NavigationStack  {
            VStack {
                Image("splash_screen")
                    .resizable()
                    .frame(width: 350,height: 260)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(hexToColor(hex: "#F9F9F7"))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        if loginStatus ?? false {
                            self.isNavigateToHomeView = true
                        } else {
                            self.isNavigateToLoginView = true
                        }
                        
                    }
                }
                
            }
            .navigationDestination(isPresented: $isNavigateToLoginView, destination: { LoginView().navigationBarBackButtonHidden(true) })
            .navigationDestination(isPresented: $isNavigateToHomeView, destination: { Homescreen().navigationBarBackButtonHidden(true) })
        }
        
    }
}

#Preview {
    SplashView()
}
