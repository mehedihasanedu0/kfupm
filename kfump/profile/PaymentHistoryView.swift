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
                
                if profileViewModel.paymentHistoryList.count == 0 {
                    NoDataFoundView()
                } else {
                    ForEach(profileViewModel.paymentHistoryList.filter { $0.totalAmount != nil },id: \.id) { item in
                        
                        SinglePaymentHistoryView(singlePayment: item)
                        .padding()
                        .background(hexToColor(hex: "#F9F9F7"))
                        .padding(.bottom,10)
                        .cornerRadius(10)
                            
                    }
                    
                    Spacer()
                }

                
            }
            .onAppear {
                profileViewModel.paymentHistory()
            }
            .padding(.horizontal)
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .navigationBarItems(leading: CustomTitleBarItems(title: LocalizationSystem.shared.localizedStringForKey(key: PAYMENT_HISSTORY_KEY, comment: "")))
            
        }  
    }
}

#Preview {
    PaymentHistoryView()
}
