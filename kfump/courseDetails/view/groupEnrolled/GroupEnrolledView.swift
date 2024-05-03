//
//  GroupEnrolledView.swift
//  kfump
//
//  Created by Mehedi Hasan on 1/5/24.
//

import SwiftUI

struct GroupEnrolledView: View {
    
    
    @StateObject var courseDetailsViewModel = CourseDetailsViewModel()
    
    var courseId : Int?
    
    var title: String
    var message: String
    var onConfirm: () -> Void
    var onCancel: () -> Void
    
    @State var emailist = [String]()
    @State var emails : String = ""
    @State var textValue : String = ""
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var showToast = false
    
    var body: some View {
        
        
        ZStack {
            
            
            VStack {
                
                HStack {
                    Text(title)
                        .font(.custom(FONT_MEDIUM, size: 20))
                    
                    Spacer()
                    
                    Image("ic_logout_close")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .onTapGesture {
                            onCancel()
                        }
                    
                }
                .padding(.horizontal)
                
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal)
                
                
                Text(message)
                    .font(.custom(FONT_LIGHT, size: 15))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                
                multipleEmailView
                
                HStack {
                    
                    Button(action: {
                        emails = ""
                        for i in 0 ..< emailist.count {
                            emails = (emails == "") ?  emailist[i] : "\(emails),\(emailist[i])"
                        }
                        print("emails => \(emails)")
                        let vm = GroupEnrollRequestModel(courseId: courseId ?? 0, email: emails)
                        print("vm => \(vm)")
                        courseDetailsViewModel.groupEnrolled(body: vm) { result in
                            showToast.toggle()
                            if result {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    onConfirm()
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }) {
                        Text("Enroll")
                            .font(.custom(FONT_MEDIUM, size: 15))
                            .frame(width: 150,height: 50)
                            .fontWeight(.bold)
                            .background(hexToColor(hex: "#007D40"))
                            .foregroundColor(.white)
                        
                    }
                    .cornerRadius(25)
                    .padding(.leading,10)
                    .padding(.top,25)
                    
                }
            }
            .padding(.vertical,30)
            .frame(width: 350,height: 550)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            
            if courseDetailsViewModel.isLoading {
                CustomProgressView()
            }
            
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: courseDetailsViewModel.dialogMessage)
            }
            
        }
        
    }
    

    
    var multipleEmailView : some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $textValue)
                .padding(4)
                .padding(.horizontal,5)
                .padding(.top,dynamicPaddingOnTop())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.3)
                )
                .onChange(of: textValue) { newValue in
                    if let lastCharacter = newValue.last, lastCharacter == " " {
                        print("Space pressed!")
                        print("textValue \(textValue)")
                        print("isValidEmail \(isValidEmail(textValue))")
                        if isValidEmail(textValue) {
                            emailist.append(textValue)
                            textValue.removeAll()
                        } else {
                            textValue = newValue.replacingOccurrences(of: " ", with: "")
                        }
                    }
                }
            
            if emailist.count != 0 {
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(emailist, id: \.self) { email in
                            SingleEmailView(email: email) {
                                if let index = emailist.firstIndex(of: email) {
                                    emailist.remove(at: index)
                                }
                            }
                            .padding(.vertical,10)
                            .padding(.leading,10)
                            
                        }
                    }
                }
                .padding(.top)

            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
        .padding(.horizontal)
    }
    
    func dynamicPaddingOnTop() -> CGFloat {
        switch(emailist.count) {
        case 1,2 :
            return 55.0
        case 3,4 :
            return 110.0
        case 5,6 :
            return 145.0
            
        default :
            return 0.0
        }
    }
}

#Preview {
    GroupEnrolledView(title: "Enrolment as a Group", message: "You can send the invitation at most 5 people at a time. They will get notification through email and need to accept the invitation in order to join.", onConfirm: {}, onCancel: {})
}
