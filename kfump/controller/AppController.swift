//
//  AppController.swift
//  kfump
//
//  Created by Mehedi Hasan on 9/4/24.
//

import Foundation
import SwiftUI

class AppController: ObservableObject {
    @Published var isRestarted: Bool = false

    func restartApp() {
        withAnimation {
            isRestarted = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.isRestarted = false
            }
        }
    }
}

