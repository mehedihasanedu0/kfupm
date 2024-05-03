//
//  SinglePaymentHistoryView.swift
//  kfump
//
//  Created by Mehedi Hasan on 4/5/24.
//

import SwiftUI

struct SinglePaymentHistoryView: View {
    
    var singlePayment : PaymentHistoryResponseModel.PaymentHistory?
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Date:")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text(DateUtils.paymentHistoryDateFormat(singlePayment?.createdAt ?? ""))
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,5)
            
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("Course Name:")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text(singlePayment?.course?.title ?? "")
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack {
                Text("Amount:")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text("SA \(doubleFormat(singlePayment?.totalAmount ?? 0.0))")
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,2)
            
            HStack {
                Text("Enrolment type:")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text(singlePayment?.enrollmentType == "PERSONAL" ? "Personal" : "")
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,2)
            .padding(.bottom,5)
            
        }
    }
}

#Preview {
    SinglePaymentHistoryView()
}
