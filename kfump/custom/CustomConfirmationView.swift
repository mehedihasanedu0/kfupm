//
//  CustomLogoutConfirmationView.swift
//  kfump
//
//  Created by Mehedi Hasan on 20/4/24.
//

import SwiftUI

struct CustomConfirmationView: View {
    var title: String
    var message: String
    var onConfirm: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack {
            
            HStack {
                Text(title)
                    .font(.custom(FONT_MEDIUM, size: 20))
                
                Spacer()
                
                Image("ic_logout_close")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .onTapGesture {
                        onCancel()
                    }
                
            }
            .padding(.horizontal)
            
            
            Divider()
                .frame(height: 1)
                .padding(.horizontal)
            
            
            Text(message)
                .font(.custom(FONT_LIGHT, size: 15))
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
            
            HStack {
                
                Button(action: {
                    
                    onCancel()
                }) {
                    Text("No")
                        .font(.custom(FONT_MEDIUM, size: 15))
                        .frame(width: 150,height: 50)
                        .fontWeight(.bold)
                        .background(.clear)
                        .foregroundColor(.black)
                    
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.gray, lineWidth: 0.3)
                }
                
                Button(action: {
                    
                    onConfirm()
                    
                }) {
                    Text("Yes")
                        .font(.custom(FONT_MEDIUM, size: 15))
                        .frame(width: 150,height: 50)
                        .fontWeight(.bold)
                        .background(hexToColor(hex: "#007D40"))
                        .foregroundColor(.white)
                    
                }
                .cornerRadius(25)
                .padding(.leading,10)
                
            }
        }
        .frame(width: 350, height: 255)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    CustomConfirmationView(title: "Confirmation", message: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly", onConfirm: {}, onCancel:  {})
}
