//
//  SetLanguage.swift
//  kfump
//
//  Created by Mehedi Hasan on 8/4/24.
//

import Foundation
import UIKit
import SwiftUI

class SetLanguage {
   static let shared = SetLanguage()
    
    
    func setLanguage(code: String) {
        LocalizationSystem.shared.setLanguage(languageCode: code)
        UIView.appearance().semanticContentAttribute =  code == "ar" ? .forceRightToLeft :  .forceLeftToRight
        //restartApps()
    }
    
    func restartApps() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.first?.rootViewController = UIHostingController(rootView: LoginView())
        windowScene.windows.first?.makeKeyAndVisible()
    
    }
}
