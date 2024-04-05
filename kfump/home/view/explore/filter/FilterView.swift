//
//  FilterView.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/3/24.
//

import SwiftUI

struct FilterView: View {
    
    var totalResult : Int = 100
    var filterValue : Int = 0
    
    var onFilterTapped: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    
                    HStack {
                        Text("\(totalResult)")
                            .font(.custom(FONT_BOLD, size: 22))
                            .bold()
                        Text("Result")
                            .fontWeight(.ultraLight)
                            .font(.custom(FONT_LIGHT, size: 22))
                            .foregroundColor(hexToColor(hex: "#D0B756"))
                            
                    }
                    Spacer()
                    
                    
                    ZStack {
                        HStack {
                            Image("ic_filter")
                                .resizable()
                                .frame(width: 20,height: 20)
                            
                            Text(filterValue == 0 ? "Filter" : "Filter (\(filterValue))")
                                .fontWeight(.ultraLight)
                                .font(.custom(FONT_REGULAR, size: 14))
                                .foregroundColor(filterValue == 0 ? .black : .white)
                                
                        }
                        .padding(10)
                        .background(filterValue != 0 ? hexToColor(hex: "#007D40") : .clear)
                        .cornerRadius(8)
                        
                        Button(action: {
                            print("Button Tapped")
                            onFilterTapped()
                        }) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 100,height: 53)
                        }
                        
                    }
                    
                    
                    
                }
                
            }
        }
    }
}

//#Preview {
//    FilterView(onFilterTapped: () -> Void)
//}
