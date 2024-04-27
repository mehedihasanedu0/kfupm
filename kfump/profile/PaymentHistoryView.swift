//
//  PaymentHistoryView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct PaymentHistoryView: View {
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                ForEach(PaymentHistoryResponseModel.sampleData) { item in
                    
                    VStack {
                        HStack {
                            Text("Date:")
                                .font(.custom(FONT_MEDIUM, size: 14))
                            Text(item.date ?? "")
                                .font(.custom(FONT_REGULAR, size: 14))
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,5)
                        
                        
                        Divider()
                            .padding(.vertical)
                        
                        HStack {
                            Text("Course Name:")
                                .font(.custom(FONT_MEDIUM, size: 14))
                            Text(item.courseName ?? "")
                                .font(.custom(FONT_REGULAR, size: 14))
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        HStack {
                            Text("Amount:")
                                .font(.custom(FONT_MEDIUM, size: 14))
                            Text(item.amount ?? "")
                                .font(.custom(FONT_REGULAR, size: 14))
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,2)
                        
                        HStack {
                            Text("Enrolment type:")
                                .font(.custom(FONT_MEDIUM, size: 14))
                            Text(item.enrolmentType ?? "")
                                .font(.custom(FONT_REGULAR, size: 14))
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,2)
                        .padding(.bottom,5)
                        
                    }
                    .padding()
                    .background(hexToColor(hex: "#F9F9F7"))
                    .padding(.bottom,10)
                    .cornerRadius(10)
                    
                    
                }
                
                Spacer()
                
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
