//
//  FilterMenuView.swift
//  kfump
//
//  Created by Mehedi Hasan on 31/3/24.
//

import SwiftUI

struct FilterMenuView: View {
    
    @StateObject var filterViewModel = FilterViewModel()
    @Binding var presentSheet :Bool
    @State private var filtersCategory = [Category]()
    @State private var filtersAvailability = [Availability]()
    @Binding var filterItemIds: [Int]
    @State var isSelectItem: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text(LocalizationSystem.shared.localizedStringForKey(key: FILTER_BY_KEY, comment: ""))
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
                
                
                Text(LocalizationSystem.shared.localizedStringForKey(key: COURSE_CATEGORY_KEY, comment: ""))
                    .font(.custom(FONT_BOLD, size: 14))
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                

                
                ForEach(Array(filtersCategory.enumerated()), id: \.element.id) { index, filterItem in
                    SingleFilterItemSelectView(isItemSelect: $filtersCategory[index].isSelect,itemName: filterItem.categoryName, onFilterItemSelect: {
                        filtersCategory[index].isSelect.toggle()
                        print("onFilterItemSelect")
                    })
                }
                
                
                Divider()
                    .padding(.vertical)
                
                
                Text(LocalizationSystem.shared.localizedStringForKey(key: AVAILABILITY_KEY, comment: ""))
                    .font(.custom(FONT_BOLD, size: 14))
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                

                ForEach(Array(filtersAvailability.enumerated()), id: \.element.id) { index, filterItem in
                    SingleFilterItemSelectView(isItemSelect: $filtersAvailability[index].isSelect,itemName: filtersAvailability[index].availabilityType, onFilterItemSelect: {
                        filtersAvailability[index].isSelect.toggle()
                        print("onFilterItemSelect")
                    })
                }

                
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    
                    Button(action: {
                        
                        filterItemIds.removeAll()
                        
                        for index in filtersCategory.indices {
                            filtersCategory[index].isSelect = false
                        }
                        
                        for index in filtersAvailability.indices {
                            filtersAvailability[index].isSelect = false
                        }
                        
                        
                    }) {
                        Text(LocalizationSystem.shared.localizedStringForKey(key: CLEAR_ALL_KEY, comment: ""))
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
                        Text(LocalizationSystem.shared.localizedStringForKey(key: APPLY_KEY, comment: ""))
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
            
            if filterViewModel.isLoading {
                CustomProgressView()
            }
            
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .onAppear {
            filterViewModel.getFilterCategoryList() { category in
                self.filtersCategory = category
            }
            filterViewModel.getFilterAvailableList() { availability in
                self.filtersAvailability = availability
            }
        }
        .padding()
        
    }
}

//
