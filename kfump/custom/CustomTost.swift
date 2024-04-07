//
//  CustomTost.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/4/24.
//

import SwiftUI

struct CustomTost: View {
    @State var message = ""
    var body: some View {
        
        Spacer()
        Text(message)
            .foregroundColor(.black)
            .padding()
            .background(hexToColor(hex: "#F8F8F8"))
            .cornerRadius(10)
        
        Spacer()
    }
}
