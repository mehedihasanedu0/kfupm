//
//  kfumpApp.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/3/24.
//

import SwiftUI

@main
struct kfumpApp: App {
    
    @AppStorage(Keys.IS_LOGIN_D.rawValue) var loginStatus: Bool?
    
    var body: some Scene {
        WindowGroup {
            
            if loginStatus ?? false {
                Homescreen()
                    .environmentObject(SharedData())
                    .environment(\.colorScheme, .light)
                    .onAppear {
                        UIView.appearance().overrideUserInterfaceStyle = .light
                    }
                
            } else {
                LoginView()
//                OTPView(emailAddress: "")
//                SplashScreen()
                    .environment(\.colorScheme, .light)
                    .onAppear {
                        UIView.appearance().overrideUserInterfaceStyle = .light
                    }
            }
        }
    }
}
