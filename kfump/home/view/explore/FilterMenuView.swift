//
//  FilterMenuView.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/3/24.
//

import SwiftUI

struct FilterMenuView: View {
    
    @Binding var presentSheet :Bool
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text("Filter By")
                        .font(.custom(FONT_NAME, size: 20))
                        .bold()
                    
                    Spacer()
                    
                    Image("ic_close")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .onTapGesture {
                            self.presentSheet = false
                        }
                    
                }
                
                Divider()
                    .padding(.vertical)
                
                Spacer()
            }
        }
        .padding()
        
    }
}

#Preview {
    FilterMenuView(presentSheet: .constant(false))
}
