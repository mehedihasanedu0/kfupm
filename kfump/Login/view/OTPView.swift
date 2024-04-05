//
//  OTPView.swift
//  kfump
//
//  Created by Mehedi Hasan on 1/4/24.
//

import SwiftUI

struct OTPView: View {
    
    @State private var otp: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix
    }
    
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSix: String = ""
    
    var body: some View {
        
        VStack {
            
            Text("Enter OTP")
                .font(.custom("Open Sans", size: 32))
                .padding(.top,70)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
            
            Divider()
                .frame(width: 56,height: 2)
                .background(hexToColor(hex: "#D0B756"))
            
            
            Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly")
                .font(.custom("Open Sans", size: 16))
                .padding(.top,20)
                .foregroundColor(hexToColor(hex: "#7A7A7A"))
                .multilineTextAlignment(.center)
            
            
            
            otpContainerView
                .padding(.top,60)
                .padding(.bottom,20)
            
            
            Button(action: {
                //isLoginButtonPress = true
                //                print("userName \(userName)")
                //                print("password \(password)")
                //
                //
                
            }) {
                Text("Confirm OTP")
                    .padding(.vertical,10)
                    .font(.custom(FONT_BOLD, size: 16))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .foregroundColor(.white)
                
            }
            
            .background(hexToColor(hex: "#007D40"))
            .frame(height: 56)
            .cornerRadius(10.0)
            .padding(.top,20)
            
            
            Spacer()
            
            
            
        }
        .padding(20)
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var otpContainerView: some View {
        
        HStack(spacing:15, content: {

            TextField("", text: $pinOne)
                .modifier(OtpModifer(pin:$pinOne))
                .onChange(of:pinOne){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinTwo
                    }
                }
                .focused($pinFocusState, equals: .pinOne)
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))

            TextField("", text:  $pinTwo)
                .modifier(OtpModifer(pin:$pinTwo))
                .onChange(of:pinTwo){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinThree
                    }else {
                        if (newVal.count == 0) {
                            pinFocusState = .pinOne
                        }
                    }
                }
                .focused($pinFocusState, equals: .pinTwo)
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))


            TextField("", text:$pinThree)
                .modifier(OtpModifer(pin:$pinThree))
                .onChange(of:pinThree){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinFour
                    }else {
                        if (newVal.count == 0) {
                            pinFocusState = .pinTwo
                        }
                    }
                }
                .focused($pinFocusState, equals: .pinThree)
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))


            TextField("", text:$pinFour)
                .modifier(OtpModifer(pin:$pinFour))
                .onChange(of:pinFour){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinFive
                    } else {
                        if (newVal.count == 0) {
                            pinFocusState = .pinThree
                        }
                    }
                }
                .focused($pinFocusState, equals: .pinFour)
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))
            
            
            TextField("", text:$pinFive)
                .modifier(OtpModifer(pin:$pinFive))
                .onChange(of:pinFive){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinSix
                    } else {
                        if (newVal.count == 0) {
                            pinFocusState = .pinFour
                        }
                    }
                }
                .focused($pinFocusState, equals: .pinFive)
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))
            
            TextField("", text:$pinSix)
                .modifier(OtpModifer(pin:$pinSix))
                .onChange(of:pinSix){newVal in
                    if (newVal.count == 0) {
                        pinFocusState = .pinFive
                    }
                }
                .focused($pinFocusState, equals: .pinSix)


        })
//                    .padding(.vertical)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 0.6)
        }
    
    }
    
}

#Preview {
    OTPView()
}
