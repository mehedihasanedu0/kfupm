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
            
            SplashView()
                .environment(\.colorScheme, .light)
                .onAppear {
                    UIView.appearance().overrideUserInterfaceStyle = .light
                }
            
            
//            if loginStatus ?? false {
//                Homescreen()
//                    .environmentObject(SharedData())
//                    .environment(\.colorScheme, .light)
//                    .onAppear {
//                        UIView.appearance().overrideUserInterfaceStyle = .light
//                    }
//                
//            } else {
//                SplashView()
////                OTPView(emailAddress: "")
////                SplashScreen()
//                    .environment(\.colorScheme, .light)
//                    .onAppear {
//                        UIView.appearance().overrideUserInterfaceStyle = .light
//                    }
//            }
        }
    }
}
