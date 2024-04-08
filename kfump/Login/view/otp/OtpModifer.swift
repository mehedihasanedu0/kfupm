//
//  OtpModifer.swift
//  kfump
//
//  Created by Mehedi Hasan on 1/4/24.
//

import SwiftUI
import Combine

struct OtpModifer: ViewModifier {

    @Binding var pin : String

    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }

    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 32, height: 56)
            .background(Color.white.cornerRadius(5))
//            .background(
//                RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color(.blue), lineWidth: 2)
//            )
    }
}
