//
//  Homescreen.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct Homescreen: View {
    
    @State private var selection = 0
    
    
    var body: some View {
        
        TabView(selection: $selection) {
            Group {
                ExploreView()
                    .tabItem {
                        selection == 0 ? Image("tab_explore_blue") : Image("tab_explore")
                        Text("Explore")
                    }
                    .tag(0)
                    .id(0)
                
                MyCourses()
                    .tabItem {
                        selection == 1 ? Image("tab_mycourse") : Image("tab_mycourse")
                        Text("My Courses").font(.custom("SST Arabic Roman", size: 14))
                    }
                    .tag(1).id(1)
                
                ProfileView().tabItem {
                    selection == 2 ? Image("tab_profile") : Image("tab_profile")
                    Image("chat")
                    Text("Profile").font(.custom("SST Arabic Roman", size: 14))
                }
                .tag(2)
                .id(2)
                
                MoreView().tabItem {
                    selection == 3 ? Image("tab_more") : Image("tab_more")
                    Text("More").font(.custom("SST Arabic Roman", size: 14))
                }
                .tag(3).id(3)
                
                
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.none, for: .tabBar)
        }
        .accentColor(hexToColor(hex: "#007D40"))
        
    }
}

#Preview {
    Homescreen()
}
