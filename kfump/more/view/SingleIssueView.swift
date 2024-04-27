//
//  SingleIssueView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct SingleIssueView: View {
    
    var singleIssue : IssueReport!
    
    
    var body: some View {
        VStack {
            HStack {
                Text("\(LocalizationSystem.shared.localizedStringForKey(key: DATE_KEY , comment: "")):")
                    .font(.custom(FONT_MEDIUM, size: 14))
                
                Text(Utils.getIssueDate(isoDate: singleIssue.createdAt ?? ""))
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,5)
            
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("\(LocalizationSystem.shared.localizedStringForKey(key: ISSUE_ID_KEY , comment: "")):")
                    .font(.custom(FONT_MEDIUM, size: 14))
                Text("#\(singleIssue.id)")
                    .font(.custom(FONT_REGULAR, size: 14))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack {
                Text("\(LocalizationSystem.shared.localizedStringForKey(key: ISSUE_NAME_KEY , comment: "")): ")
                    .font(.custom(FONT_MEDIUM, size: 14))
                + Text(singleIssue.description ?? "")
                                .font(.custom(FONT_REGULAR, size: 14))
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top,2)
            
            HStack {
                Text(singleIssue.status ?? "")
                    .font(.custom(FONT_MEDIUM, size: 14))
                    .padding(.vertical,6)
                    .padding(.horizontal,15)
                    .foregroundColor(!(singleIssue.status == "Pending") ? hexToColor(hex: "#007D40") : hexToColor(hex: "#D0B756"))
                    .background(!(singleIssue.status == "Pending") ? hexToColor(hex: "#007D40",alpha: 0.2) : hexToColor(hex: "#D0B756",alpha: 0.2))
                    .cornerRadius(15)
                
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    SingleIssueView()
}
