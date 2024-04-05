//
//  FilterMenuView.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/3/24.
//

import SwiftUI

struct FilterMenuView: View {
    
    @Binding var presentSheet :Bool
    @State private var filtersCategory = sampleDataCategoryFilter
    @State private var filtersAvailability = sampleDataAvailableFilter
    @Binding var filterItemIds: [Int]
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text("Filter By")
                        .font(.custom(FONT_BOLD, size: 20))
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
                
                
                Text("course Category")
                    .font(.custom(FONT_BOLD, size: 14))
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                ForEach(Array(filtersCategory.enumerated()), id: \.element.id) { index, filterItem in
                    SingleFilterItemSelectView(isItemSelect: $filtersCategory[index].isSelect,itemName: filterItem.title, onFilterItemSelect: {
                        filtersCategory[index].isSelect.toggle()
                        print("onFilterItemSelect")
                    })
                }
                
                
                Divider()
                    .padding(.vertical)
                
                
                Text("Availability")
                    .font(.custom(FONT_BOLD, size: 14))
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                ForEach(Array(filtersAvailability.enumerated()), id: \.element.id) { index, filterItem in
                    SingleFilterItemSelectView(isItemSelect: $filtersAvailability[index].isSelect,itemName: filterItem.title, onFilterItemSelect: {
                        filtersAvailability[index].isSelect.toggle()
                        print("onFilterItemSelect")
                    })
                }
                
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    
                    Button(action: {
                        
                        filterItemIds.removeAll()
                        
                    }) {
                        Text("Clear All")
                            .font(.custom(FONT_REGULAR, size: 14))
                            .bold()
                            .foregroundColor(.black)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.gray, lineWidth: 0.3)
                    }
                
                    
                    
                    Button(action: {
                        
                        filterItemIds.removeAll()
                        
                        for filterItem in filtersCategory {
                            if filterItem.isSelect {
                                filterItemIds.append(filterItem.id)
                            }
                        }  
                        
                        for filterItem in filtersAvailability {
                            if filterItem.isSelect {
                                filterItemIds.append(filterItem.id)
                            }
                        }
                        
                        self.presentSheet = false
                        
                        
                    }) {
                        Text("Apply")
                            .font(.custom(FONT_REGULAR, size: 14))
                            .bold()
                            .foregroundColor(.white)
                            
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(hexToColor(hex: "#007D40"))
                    .cornerRadius(24)
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                
                
                Spacer()
            }
        }
        .padding()
        
    }
}

#Preview {
    FilterMenuView(presentSheet: .constant(false), filterItemIds: .constant([Int]()))
}
