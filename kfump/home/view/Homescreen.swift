//
//  Homescreen.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct Homescreen: View {
    
    @State private var selection = 0
    @StateObject var authenicationViewModel = AuthenicationViewModel()
    @AppStorage(Keys.refreshToken.rawValue) var refreshToken: String?
    
    var body: some View {
        NavigationStack  {
            
            TabView(selection: $selection) {
                Group {
                    ExploreView()
                        .tabItem {
                            selection == 0 ? Image("tab_explore_blue") : Image("tab_explore")
                            Text(LocalizationSystem.shared.localizedStringForKey(key: EXPLORE_KEY, comment: ""))
                        }
                        .tag(0)
                        .id(0)
                    
                    MyCourses()
                        .tabItem {
                            selection == 1 ? Image("tab_mycourse") : Image("tab_mycourse")
                            Text(LocalizationSystem.shared.localizedStringForKey(key: My_COURSES_KEY, comment: "")).font(.custom("SST Arabic Roman", size: 14))
                        }
                        .tag(1).id(1)
                    
                    ProfileView().tabItem {
                        selection == 2 ? Image("tab_profile") : Image("tab_profile")
                        Image("chat")
                        Text(LocalizationSystem.shared.localizedStringForKey(key: PROFILE_KEY, comment: "")).font(.custom("SST Arabic Roman", size: 14))
                    }
                    .tag(2)
                    .id(2)
                    
                    MoreView().tabItem {
                        selection == 3 ? Image("tab_more") : Image("tab_more")
                        Text(LocalizationSystem.shared.localizedStringForKey(key: MORE_KEY, comment: "")).font(.custom("SST Arabic Roman", size: 14))
                    }
                    .tag(3).id(3)
                    
                    
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.none, for: .tabBar)
            }
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
            .accentColor(hexToColor(hex: "#007D40"))
            .onAppear {
                print("isJWTTokenExpire => \(Utils.isJWTTokenExpire())")
                if Utils.isJWTTokenExpire() {
                    let vm = RefreshTokenRequestModel(refreshToken: refreshToken)
                    authenicationViewModel.refreshToken(body: vm)
                }
                
            }
            
        }
    }
}

#Preview {
    Homescreen()
}
