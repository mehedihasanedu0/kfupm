//
//  PaymentHistoryView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct PaymentHistoryView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                ForEach(profileViewModel.paymentHistoryList,id: \.id) { item in
                    
                    SinglePaymentHistoryView(singlePayment: item)
                    .padding()
                    .background(hexToColor(hex: "#F9F9F7"))
                    .padding(.bottom,10)
                    .cornerRadius(10)
                    
                    
                }
                
                Spacer()
                
            }
            .onAppear {
                profileViewModel.paymentHistory()
            }
            .padding(.horizontal)
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .navigationBarItems(leading: CustomTitleBarItems(title: "Payment History"))
            
        }  
    }
}

#Preview {
    PaymentHistoryView()
}
