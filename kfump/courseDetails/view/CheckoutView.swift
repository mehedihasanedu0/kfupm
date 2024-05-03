//
//  CheckoutView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/4/24.
//

import SwiftUI

struct CheckoutView: View {
    
    var enrolledData : CourseEnrolledData?
    
    @State var isPaymentTypeCash = true
    @StateObject var courseDetailsViewModel = CourseDetailsViewModel()
    @State private var showToast = false
    @State private var isNavigateToEnrolledCourseView = false
    @State private var paymentMethod = "Cash"
    
    var body: some View {
        
        
        ZStack {
            ScrollView {
                VStack {
                    
                    Text("Figma UI UX Design Essentials for Beginners")
                        .font(.custom(FONT_BOLD, size: 20))
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Learn javascript online and supercharge your web design with this Javascript for beginners training course.")
                        .font(.custom(FONT_LIGHT, size: 16))
                        .padding(.vertical,5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Divider()
                        .padding(.vertical)
                    
                    paymentMethodView
                    
                    summeryView
                        .padding(.top,50)
                    
                }
                .padding(.horizontal)
                .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
                .navigationBarItems(leading: CustomTitleBarItems(title: "Checkout"))
                .navigationDestination(isPresented: $isNavigateToEnrolledCourseView, destination: {
                    EnrolledCoursesView().navigationBarBackButtonHidden(true) })
            }
            
            if courseDetailsViewModel.isLoading {
                CustomProgressView()
            }
            
            ToastView(isPresented: $showToast, duration: 2.0) {
                CustomTost(message: courseDetailsViewModel.dialogMessage)
            }
        }
        

        
        
    }
    
    
    var summeryView: some View {
        
        VStack {
            Text("Summery")
                .font(.custom(FONT_SEMIBOLD, size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Original Price")
                    .font(.custom(FONT_REGULAR, size: 14))
                
                Spacer()
                Text("SR\(enrolledData?.serviceCost ?? "0.00")")
                    .font(.custom(FONT_SEMIBOLD, size: 14))
                
            }
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Divider()
                .padding(.vertical)
            
            // VAT Percentage
            HStack {
                Text("VAT %")
                    .font(.custom(FONT_REGULAR, size: 14))
                Spacer()
                Text("SR\(enrolledData?.vatPercent ?? "0.00")")
                    .font(.custom(FONT_SEMIBOLD, size: 14))
            }
            
            
            HStack {
                Text("Total Price")
                    .font(.custom(FONT_SEMIBOLD, size: 14))
                Spacer()
                Text("SR\(enrolledData?.totalAmount ?? "0.00")")
                    .font(.custom(FONT_SEMIBOLD, size: 14))
            }
            .padding(.top,10)
            
            
            Text("By completing your purchase you agree these")
                .font(.custom(FONT_REGULAR, size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.gray)
                .padding(.top)
            
            
            Text("Terms of Service")
                .font(.custom(FONT_MEDIUM, size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(hexToColor(hex: "#007D40"))
            
            
            Button(action: {
                
                
                let vm = SinglePaymentRequestModel(courseId: enrolledData?.course ?? 0, paymentMethod: isPaymentTypeCash ? "Cash" : "Pay tab")
                
                courseDetailsViewModel.singlePayment(body: vm) { result in
                    showToast.toggle()
                    if result {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isNavigateToEnrolledCourseView = true
                        }
                        
                    }
                    
                }
                
                
                
            }) {
                Text("Proceed")
                    .padding(.vertical,10)
                    .font(.custom(FONT_BOLD, size: 16))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .foregroundColor(.white)
                
            }
            .background(hexToColor(hex: "#007D40"))
            .frame(height: 56)
            .cornerRadius(27.0)
            .padding(.top,20)
            .padding(.bottom,30)
            
            
        }
        .padding()
        .background(hexToColor(hex: "#E5E5D9",alpha: 0.4))
        .cornerRadius(10)
    }
    
    
    var paymentMethodView: some View {
        
        VStack {
            Text("Payment Method")
                .font(.custom(FONT_SEMIBOLD, size: 16))
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            GeometryReader { geometry in
                HStack {
                    HStack {
                        Image(isPaymentTypeCash ? "toggle_select" : "toggle_unselect")
                            .resizable()
                            .frame(width: 20,height: 20)
                        
                        Text("Cash")
                            .font(.custom(FONT_MEDIUM, size: 14))
                    }
                    .padding(.vertical,8)
                    .frame(width: geometry.size.width / 2 - 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(hexToColor(hex: "#E5E5D9"), lineWidth: 1)
                    }
                    .onTapGesture {
                        isPaymentTypeCash = true
                    }
                    
                    HStack {
                        Image(isPaymentTypeCash ? "toggle_unselect" : "toggle_select")
                            .resizable()
                            .frame(width: 20,height: 20)
                        
                        Text("Pay Tab")
                            .font(.custom(FONT_MEDIUM, size: 14))
                    }
                    .onTapGesture {
                        isPaymentTypeCash = false
                    }
                    .padding(.vertical,8)
                    .frame(width: geometry.size.width / 2 - 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(hexToColor(hex: "#E5E5D9"), lineWidth: 1)
                    }
                }
                .frame(width: geometry.size.width, alignment: .leading)
            }
            
        }
    }
    
    
}

#Preview {
    CheckoutView()
}
