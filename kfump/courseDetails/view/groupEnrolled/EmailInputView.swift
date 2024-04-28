//
//  EmailInputView.swift
//  kfump
//
//  Created by Mehedi Hasan on 28/4/24.
//

import SwiftUI

struct EmailInputView: View {
    @State private var emails: [String] = []
    @State private var currentEmailInput: String = ""
    @FocusState private var isInputFieldFocused: Bool

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))

                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(emails, id: \.self) { email in
                                TagView(email: email) {
                                    if let index = emails.firstIndex(of: email) {
                                        emails.remove(at: index)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 8)
                    }
                    
                    TextField("Enter email", text: $currentEmailInput)
                        .focused($isInputFieldFocused)
                        .onSubmit {
                            addEmail()
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isInputFieldFocused = true
                            }
                        }
                }
                .padding(.horizontal)
            }
            .frame(height: 50)
        }
        .padding()
    }

    private func addEmail() {
        let newEmail = currentEmailInput.trimmingCharacters(in: .whitespacesAndNewlines)
        if isValidEmail(newEmail) {
            emails.append(newEmail)
            currentEmailInput = ""
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        // Add your email validation regex or logic here
        !email.isEmpty
    }
}

#Preview {
    EmailInputView()
}
