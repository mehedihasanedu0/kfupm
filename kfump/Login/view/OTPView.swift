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
    
    var emailAddress : String
    
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix, pinSeven
    }
    
    var source : String
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSix: String = ""
    @State var pinSeven: String = ""
    
    @State private var showToast = false
    
    @State var isNavigateToHomeScreen: Bool = false
    @State var isNavigateToLogin: Bool = false
    @State var isNavigateToResetPassword: Bool = false
    @StateObject var authonicationViewModel = AuthenicationViewModel()
    
    @State var OTP : String = ""
    
    var body: some View {
        
        
        ZStack {
            
            VStack {
                
                Text(LocalizationSystem.shared.localizedStringForKey(key: ENTER_OTP_KEY, comment: ""))
                    .font(.custom(FONT_REGULAR , size: 32))
                    .padding(.top,20)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .frame(width: 56,height: 2)
                    .background(hexToColor(hex: "#D0B756"))
                    .offset(y: -15)
                
                
                Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly")
                    .font(.custom("Open Sans", size: 16))
                    .padding(.top,10)
                    .foregroundColor(hexToColor(hex: "#7A7A7A"))
                    .multilineTextAlignment(.center)
                
                
                ZStack {
                    
                    CustomOtpView { value in
                        print("value => \(value)")
                        OTP = value
                    }
                    
                    
                    
                    Button {
                        print("Otp Container View")
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 60)
                    }
                    .padding(.top,40)
                    .allowsHitTesting(true)
                    
                }
               
                
                
                Button(action: {
                    
                    print("otp => \(otp)")
                    
                   
                    print("otp => \(OTP)")
                    
                    if otp.count != 6 {
                        return
                    }
                    
                    let vm = OtpModel(emailOrPhone: emailAddress,
                                      otpCode: OTP)
                    
                    authonicationViewModel.otpVerify(body: vm,isAutoLogin: (source == "registration")) { result in
                        showToast.toggle()
 
                        if result {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                print("source > \(source) ")
                                if source == "resetPassword" {
                                    isNavigateToResetPassword = true
                                } else {
                                    isNavigateToHomeScreen = true
                                }
                                
                            }
                        }
                    }

                }) {
                    Text(LocalizationSystem.shared.localizedStringForKey(key: CONFIRM_OTP_KEY, comment: ""))
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
            .navigationDestination(isPresented: $isNavigateToHomeScreen, destination: { Homescreen().navigationBarBackButtonHidden(true) })
            .navigationDestination(isPresented: $isNavigateToResetPassword, destination: { ResetPasswordView(token: authonicationViewModel.token ).navigationBarBackButtonHidden(true) })
            
            if authonicationViewModel.isLoading {
                CustomProgressView()
            }
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: authonicationViewModel.dialogMessage)
            }
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        
        
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var otpContainerView: some View {
        
        HStack(spacing:10, content: {

            CustomOtpTextField(text: $pinOne)
                .modifier(OtpModifer(pin:$pinOne))
                .onChange(of:pinOne){newVal in
                    
                    if let range = newVal.range(of: ""), range.isEmpty {
                        print("Delete key pressed while textField is empty")
                    }
                    if (newVal.count == 1) {
                        pinFocusState = .pinTwo
                    } else if (newVal.count == 0) {
                       pinFocusState = .pinOne
                   }
                }
                .focused($pinFocusState, equals: .pinOne)
                .onReceive(pinOne.publisher.last()) { val in
                    print("val: \(val)")
//                    if string.count < prevString.count {
//                        print("backspace pressed, do something clever here")
//                    } else {
//                        print("val: \(val)")
//                    }
                }
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))

            CustomOtpTextField(text:  $pinTwo)
                .modifier(OtpModifer(pin:$pinTwo))
                .onChange(of:pinTwo){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinThree
                    } else if (newVal.count == 0) {
                        pinFocusState = .pinOne
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
                    } else if (newVal.count == 0) {
                        pinFocusState = .pinTwo
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
                    } else if (newVal.count == 0) {
                        pinFocusState = .pinThree
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
                    } else if (newVal.count == 0) {
                        pinFocusState = .pinFour
                    }
                }
                .focused($pinFocusState, equals: .pinFive)
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))
            
            TextField("", text:$pinSix)
                .modifier(OtpModifer(pin:$pinSix))
                .onChange(of:pinSix){newVal in
                    if (newVal.count == 1) {
                        pinFocusState = .pinSeven
                    } else if (newVal.count == 0) {
                        pinFocusState = .pinFive
                    }
                }
                .focused($pinFocusState, equals: .pinSix)   
                
            
            Divider()
                .frame(width: 1,height: 36)
                .foregroundColor(hexToColor(hex: "#E0E0DC"))
            
            TextField("", text:$pinSeven)
                .modifier(OtpModifer(pin:$pinSeven))
                .onChange(of:pinSeven) {newVal in
                    if (newVal.count == 0) {
                        pinFocusState = .pinSix
                    } else if newVal.count == 1 {
                        pinFocusState = .pinSeven
                        hideKeyboard()
                    }
                }
                .focused($pinFocusState, equals: .pinSeven)


        })
//                    .padding(.vertical)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 0.6)
        }
    
    }
    
}

#Preview {
    OTPView(emailAddress: "", source: "")
}
