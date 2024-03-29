//
//  kfumpApp.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/3/24.
//

import SwiftUI

@main
struct kfumpApp: App {
    var body: some Scene {
        WindowGroup {
            let loginStatus = UserDefaults.standard.bool(forKey: IS_LOGIN_D)
            
            if loginStatus {
//                Homescreen()
//                    .environmentObject(SharedData())
//                    .environment(\.colorScheme, .light)
//                    .onAppear {
//                        UIView.appearance().overrideUserInterfaceStyle = .light
//                    }
                
            } else {
                LoginView()
//                SplashScreen()
//                    .environment(\.colorScheme, .light)
//                    .onAppear {
//                        UIView.appearance().overrideUserInterfaceStyle = .light
//                    }
            }
        }
    }
}
