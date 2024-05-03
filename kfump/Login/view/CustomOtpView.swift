//
//  CustomOtpView.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/5/24.
//

import SwiftUI

struct CustomOtpView: View {
    private let doSomething: (String) -> Void
    private var length: Int = 7
    
    @State private var otpText = ""
    @FocusState private var isKeyboardShowing: Bool
    var backgroundColor : Color = .clear
    
    public init(doSomething: @escaping (String) -> Void) {
        self.doSomething = doSomething
    }
    
    public var body: some View {
        HStack(spacing: 0){
            ForEach(0...length-1, id: \.self) { index in
                OTPTextBox(index)
                
                Divider()
                    .frame(width: 1,height: 30)
                    .background(hexToColor(hex: "#E0E0DC"))
            }
            
        }.background(content: {
            TextField("", text: $otpText.limit(7))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .frame(width: 1, height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isKeyboardShowing)
                .onChange(of: otpText) { newValue in
                    if newValue.count == length {
                        doSomething(newValue)
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        isKeyboardShowing = true
                    }
                }
        })
        .contentShape(Rectangle())
        .onTapGesture {
            isKeyboardShowing = true
        }
        .overlay {
            RoundedRectangle(cornerRadius: 7)
                .stroke(hexToColor(hex: "#E5E5D9"), lineWidth: 1)
        }
    }
    
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            } else {
                Text(" ")
            }
            
            if (isKeyboardShowing && otpText.count == index) {
                Divider()
                    .frame(width: 15,height: 2)
                    .background(hexToColor(hex: "#333333"))
                    .offset(y: 10)
            }
           
        }
        .frame(width: 40, height: 50)
//        .background {
//            let status = (isKeyboardShowing && otpText.count == index)
//            RoundedRectangle(cornerRadius: 6, style: .continuous)
//                .stroke(status ? activeIndicatorColor : inactiveIndicatorColor)
//                .animation(.easeInOut(duration: 0.2), value: status)
//            
//        }
        .padding(.horizontal,5)
    }
}

@available(iOS 13.0, *)
extension Binding where Value == String {
    func limit(_ length: Int)->Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}



#Preview {
    CustomOtpView(doSomething: { value in
        
    })
    .padding()
}
