//
//  ExploreView.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/3/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State var searchValue: String = ""
    
    var courses: [Course] = Course.sampleData // Replace with your data source
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    
                    SearchView(fieldName: "Search courses", value: $searchValue)
                        .padding(.top)
                    
                    HStack {
                        HStack {
                            Text("Browse")
                                .font(.custom(FONT_NAME, size: 22))
                                .bold()
                            Text("Course")
                                .fontWeight(.ultraLight)
                                .font(.custom(FONT_NAME, size: 22))
                                .foregroundColor(hexToColor(hex: "#D0B756"))
                                
                        }
                        Spacer()
                    }
                    .padding(.top,30)
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(courses, id: \.id) { course in
                                SingleCourseView(course: course)
                            }
                        }.padding(.top,15)
                    }
                    
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal,20)
            
        }
    }
}

#Preview {
    ExploreView()
}
