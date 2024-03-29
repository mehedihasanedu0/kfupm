//
//  ContentView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var userName: String = ""
    @State var password: String = ""
    @State var isLoginButtonPress: Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    Button(action: {
                        
                    }) {
                        Text("Sign Up Later")
                            .padding(.vertical,10)
                            .font(.custom(FONT_NAME, size: 14))
                            .foregroundColor(hexToColor(hex: "#007D40"))
                        
                    }
                    Spacer()
                }
                
                Text("Welcome to \nContinuing Education \nPrograms")
                    .font(.custom("Open Sans", size: 32))
                    .padding(.top,20)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .frame(width: 56,height: 2)
                    .background(hexToColor(hex: "#D0B756"))
                
                CustomTextField(fieldName: "Email/Phone",
                                value: $userName,
                                emptyErrorMessage: "User Name Can't be empty",
                                isButtonPress: isLoginButtonPress)
                .padding(.top,40)
                        
                
                CustomSecureTextField(fieldName: "Password",
                                      password: $password,
                                      emptyErrorMessage: "Password can't be empty",
                                      isButtonPress: isLoginButtonPress)
                .padding(.top,15)
                        
                
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Forget Password")
                            .padding(.vertical,10)
                            .font(.custom(FONT_NAME, size: 14))
                            .foregroundColor(hexToColor(hex: "#7C7C7C"))
                        
                    }
                    
                }
                
                Button(action: {
                    isLoginButtonPress = true
                    print("userName \(userName)")
                    print("password \(password)")
                    
                }) {
                    Text("Login")
                        .padding(.vertical,10)
                        .font(.custom(FONT_NAME, size: 16))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,20)
                        .foregroundColor(.white)
                    
                }
                .background(hexToColor(hex: "#007D40"))
                .frame(height: 56)
                .cornerRadius(10.0)
                .padding(.top,20)
                
                
                HStack {
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .padding(.horizontal,5)
                        .background(hexToColor(hex: "#E5E5D9"))
                    
                    Text("Or")
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .padding(.horizontal,5)
                        .background(hexToColor(hex: "#E5E5D9"))
                }
                .padding(.top,20)
                
                
                Button(action: {
                    print("userName \(userName)")
                    print("password \(password)")
                    
                }) {
                    Text("Continue with KFU ID")
                        .padding(.vertical,10)
                        .font(.custom(FONT_NAME, size: 16))
                        .foregroundColor(.black)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,20)
                        .foregroundColor(.white)
                    
                }
                
                .frame(height: 56)
                .cornerRadius(10.0)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 0.3)
                }
                .padding(.top,20)
                
                HStack {
                    Text("Don’t have an account?")
                        .font(.custom(FONT_NAME, size: 14))
                    
                    Button(action: {
                        print("Registration")
                        print("password \(password)")
                        
                    }) {
                        Text("Registration")
                            .font(.custom(FONT_NAME, size: 14))
                            .bold()
                            .foregroundColor(hexToColor(hex: "#007D40"))
                        
                    }
                  
                }
                .padding(.top,20)
                
            }
            .padding(20)
            
            
        }
    }
}

//#Preview {
//    ContentView()
//}
