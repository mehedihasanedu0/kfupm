//
//  ToastView.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/4/24.
//

import SwiftUI

struct ToastView<Content: View>: View {
    let isPresented: Binding<Bool>
    let duration: Double
    let content: () -> Content

    var body: some View {
        
        ZStack {
            if isPresented.wrappedValue {
                content()
                    .transition(.slide)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}
