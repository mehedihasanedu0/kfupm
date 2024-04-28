//
//  EmailChipsView.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/4/24.
//

import SwiftUI

struct EmailChipsView: View {
    
    @State private var emails: [String] = []
    @State private var currentEmailInput: String = ""
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(emails, id: \.self) { email in
                        EmailChipView(email: email) {
                            if let index = emails.firstIndex(of: email) {
                                emails.remove(at: index)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            HStack {
                TextField("Add email", text: $currentEmailInput, onCommit: {
                    addEmail()
                })
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
                Button(action: addEmail) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
    private func addEmail() {
        if !currentEmailInput.isEmpty {
            emails.append(currentEmailInput)
            currentEmailInput = ""
        }
    }
}

#Preview {
    EmailChipsView()
}
