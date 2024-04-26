//
//  SplashView.swift
//  kfump
//
//  Created by Mehedi Hasan on 26/4/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Image("splash_screen")
                .resizable()
                .frame(width: 316,height: 240)
        }
        .background(hexToColor(hex: "#F9F9F7"))
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    SplashView()
}
