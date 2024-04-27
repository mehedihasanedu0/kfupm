//
//  AttendanceHistoryView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct AttendanceHistoryView: View {
    
    @State var isPresent : Bool = false
    
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
                            Text("Student name:")
                                .font(.custom(FONT_MEDIUM, size: 14))
                            Text("Mehedi Hasan ")
                                .font(.custom(FONT_REGULAR, size: 14))
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        HStack {
                            Text("Course name:")
                                .font(.custom(FONT_MEDIUM, size: 14))
                            + Text(" Conduct UX Research and Test Early Concepts")
                                .font(.custom(FONT_REGULAR, size: 14))
                            
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,2)
                        
                        HStack {
                            Text("Present")
                                .font(.custom(FONT_MEDIUM, size: 14))
                                .padding(.vertical,6)
                                .padding(.horizontal,15)
                                .foregroundColor(isPresent ? hexToColor(hex: "#007D40") : hexToColor(hex: "#DA2D21"))
                                .background(isPresent ? hexToColor(hex: "#007D40",alpha: 0.2) : hexToColor(hex: "#DA2D21",alpha: 0.2))
                                .cornerRadius(15)
                            
                            Spacer()
                        }
                        
                        
                    }
                    .padding()
                    .padding(.bottom,10)
                    .background(hexToColor(hex: "#F9F9F7"))
                    .cornerRadius(10)
                    
                    
                }
                .padding(.top)
                
                Spacer()
                
            }
            .padding(.horizontal)
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .navigationBarItems(leading: CustomTitleBarItems(title: "Attandance History"))
            
        }
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
    }
}

#Preview {
    AttendanceHistoryView()
}
