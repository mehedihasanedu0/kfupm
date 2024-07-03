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
    
    @State var firstEmail : String = ""
    @State var secoundEmail : String = ""
    @State var thirdEmail : String = ""
    @State var fourthEmail : String = ""
    @State var fiveEmail : String = ""
    
    @FocusState private var isFocusfirstEmail : Bool
    @FocusState private var isFocussecoundEmail: Bool
    @FocusState private var isFocusThirdEmail: Bool
    @FocusState private var isFocusFourthEmail: Bool
    @FocusState private var isFocusfiveEmail : Bool
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var showToast = false
    @State private var showToastIfEmailIdentical = false
    @State private var customMessage: String = "Please provide a valid email"
    
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
                    .padding(.top,15)
                    
                }
            }
            .padding(.vertical,30)
            .frame(width: 350,height: 490)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            
            if courseDetailsViewModel.isLoading {
                CustomProgressView()
            }
            
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: courseDetailsViewModel.dialogMessage)
            } 
            
            ToastView(isPresented: $showToastIfEmailIdentical, duration: 2.0) {
                CustomTost(message: customMessage)
            }
            
        }
  
        
    }
    

    
    var multipleEmailView : some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .topLeading) {
                
                VStack {
                    
                    HStack {
                        
                        if emailist.count >= 1 {
                            SingleEmailView(email: emailist[0]) {
                                if let index = emailist.firstIndex(of: emailist[0]) {
                                    emailist.remove(at: index)
                                    dynamicFocusPoint()
                                }
                            }
                            .frame(width: geometry.size.width / 2 - 30)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            
                            
                            
                        } else {
                            TextField("", text: $firstEmail)
                                .padding(5)
                                .cornerRadius(20.0)
                                .focused($isFocusfirstEmail)
                                .onChange(of: firstEmail) { value in
                                    print("firstEmail => \(value)")
                                    if let lastCharacter = value.last, lastCharacter == " " {
                                        if addEmail(value) {
                                            firstEmail = ""
                                        }
                                    }
                                    
                                }
                                
                                .onAppear{
                                    dynamicFocusPoint()
                                }
                        }
                        
                        
                        if emailist.count >= 2 {
                            SingleEmailView(email: emailist[1]) {
                                if let index = emailist.firstIndex(of: emailist[1]) {
                                    emailist.remove(at: index)
                                    dynamicFocusPoint()
                                }
                            }
                            .frame(width: geometry.size.width / 2 - 30)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            
                        } else {
                            TextField("", text: $secoundEmail,
                                      prompt: Text(secoundEmail))
                            .padding(5)
                            .cornerRadius(20.0)
                            .focused($isFocussecoundEmail)
                            .onChange(of: secoundEmail) { value in
                                if let lastCharacter = value.last, lastCharacter == " " {
                                    if addEmail(value) {
                                        secoundEmail = ""
                                    }
                                    
                                }
                            }
                            .onAppear {
                                dynamicFocusPoint()
                            }
                        }
                        
                        
                        
                        
                    }
                    .padding(.horizontal,10)
                    .padding(.top,20)
                    
                    HStack {
                        
                        if emailist.count >= 3 {
                            SingleEmailView(email: emailist[2]) {
                                if let index = emailist.firstIndex(of: emailist[2]) {
                                    emailist.remove(at: index)
                                    dynamicFocusPoint()
                                }
                            }
                            .frame(width: geometry.size.width / 2 - 30)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            
                        } else {
                            TextField("Mehedi", text: $thirdEmail,
                                      prompt: Text(thirdEmail))
                            .padding(5)
                            .cornerRadius(20.0)
                            .focused($isFocusThirdEmail)
                            .onChange(of: thirdEmail) { value in
                                print("thirdEmail => \(value)")
                                if addEmail(value) {
                                    thirdEmail = ""
                                }
                            }
                            .onAppear{
                                dynamicFocusPoint()
                            }
                            
                        }
                        
                        if emailist.count >= 4 {
                            SingleEmailView(email: emailist[3]) {
                                if let index = emailist.firstIndex(of: emailist[3]) {
                                    emailist.remove(at: index)
                                    dynamicFocusPoint()
                                }
                            }
                            .frame(width: geometry.size.width / 2 - 30)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            
                        } else {
                            TextField("Mehedi", text: $fourthEmail,
                                      prompt: Text(fourthEmail))
                            .padding(5)
                            .cornerRadius(20.0)
                            .focused($isFocusFourthEmail)
                            .onChange(of: fourthEmail) { value in
                                if let lastCharacter = value.last, lastCharacter == " " {
                                    if addEmail(value) {
                                        fourthEmail = ""
                                    }
                                }
                            }
                            .onAppear{
                                dynamicFocusPoint()
                            }
                            
                        }
                        
                        
                        
                    }
                    .padding(.horizontal,10)
                    .padding(.top,10)
                    
                    HStack {
                        
                        if emailist.count == 5 {
                            SingleEmailView(email: emailist[4]) {
                                if let index = emailist.firstIndex(of: emailist[4]) {
                                    emailist.remove(at: index)
                                    dynamicFocusPoint()
                                }
                            }
                            .frame(width: geometry.size.width / 2 - 30)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            
                        } else {
                            TextField("Mehedi", text: $fiveEmail,
                                      prompt: Text(fiveEmail))
                            .padding(5)
                            .cornerRadius(20.0)
                            .focused($isFocusfiveEmail)
                            .onChange(of: fiveEmail) { value in
                                if let lastCharacter = value.last, lastCharacter == " " {
                                    if addEmail(value) {
                                        fiveEmail = ""
                                    }
                                }
                            }
                            .onAppear{
                                dynamicFocusPoint()
                            }
                            
                        }
                        
                        
                        
                        Spacer()
                    }
                    .padding(.horizontal,10)
                    .padding(.top,10)
                    
                    
                    Spacer()
                    
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                
            }
            .onTapGesture {
                dynamicFocusPoint()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 0.3)
            )
            .padding(.horizontal)
            
        }
        
    }
    
    func addEmail(_ textValue : String) -> Bool {
        
        if let lastCharacter = textValue.last, lastCharacter == " " {
           
            if isValidEmail(textValue) {
                
                if emailist.count == 5 {
                    customMessage = "You can send the invitation at most 5 people at a time"
                    showToastIfEmailIdentical.toggle()
                    return false
                }
                
                if emailist.contains(textValue) {
                    customMessage = "This email is already provided"
                    showToastIfEmailIdentical.toggle()
                    return false
                }
                print("textValue => \(textValue)")
                emailist.append(textValue)
                dynamicFocusPoint()
                return true
                
            } else {
                customMessage = "Please provide a valid email"
                showToastIfEmailIdentical.toggle()
                return false
            }
        }
        
        return false
    }
    
//    var multipleEmailView : some View {
//        ZStack(alignment: .topLeading) {
//            TextEditor(text: $textValue)
//                .padding(4)
//                .padding(.horizontal,5)
//                .padding(.top,dynamicPaddingOnTop())
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.gray, lineWidth: 0.3)
//                )
//                .onChange(of: textValue) { newValue in
//                    
////                    if newValue != "" && newValue.contains("\n") {
////                        hideKeyboard()
////                        textValue.removeAll()
////                        return
////                    }
//                    
//                    
//                    if let lastCharacter = newValue.last, lastCharacter == " " {
//                        if isValidEmail(textValue) {
//                            
//                            if emailist.count == 5 {
//                                showToastIfEmailIdentical = true
//                                customMessage = "You can send the invitation at most 5 people at a time"
//                                return
//                            }
//                            
//                            if emailist.contains(textValue) {
//                                showToastIfEmailIdentical = true
//                                customMessage = "This email is already provided"
//                                return
//                            }
//                            emailist.append(textValue)
//                            textValue.removeAll()
//                            
//                        } else {
//                            showToastIfEmailIdentical = true
//                            customMessage = "Please provide a valid email"
//                            textValue = newValue.replacingOccurrences(of: " ", with: "")
//                        }
//                    }
//                }
//            
//            if emailist.count != 0 {
//                
//                ScrollView(.vertical, showsIndicators: false) {
//                    LazyVGrid(columns: columns, spacing: 0) {
//                        ForEach(emailist, id: \.self) { email in
//                            SingleEmailView(email: email) {
//                                if let index = emailist.firstIndex(of: email) {
//                                    emailist.remove(at: index)
//                                }
//                            }
//                            .padding(.vertical,10)
//                            .padding(.leading,10)
//                            
//                        }
//                    }
//                }
//                .padding(.top)
//
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .frame(height: 180)
//        .padding(.horizontal)
//    }
    
    func dynamicFocusPoint()  {
        switch(emailist.count) {
        case 0 :
            setFocusFalse()
            isFocusfirstEmail = true
        case 1:
            setFocusFalse()
            isFocussecoundEmail = true
        case 2 :
            setFocusFalse()
            isFocusThirdEmail = true
        case 3 :
            setFocusFalse()
            isFocusFourthEmail = true
        case 4 :
            setFocusFalse()
            isFocusfiveEmail = true
            
        default :
            isFocusfirstEmail = true
        }
    }
    
    func setFocusFalse() {
        isFocusfirstEmail = false
        isFocussecoundEmail = false
        isFocusThirdEmail = false
        isFocusFourthEmail = false
        isFocusfiveEmail = false
    }
}

#Preview {
    GroupEnrolledView(title: "Enrolment as a Group", message: "You can send the invitation at most 5 people at a time. They will get notification through email and need to accept the invitation in order to join.", onConfirm: {}, onCancel: {})
}
