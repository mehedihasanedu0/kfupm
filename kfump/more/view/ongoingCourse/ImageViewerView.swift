//
//  ImageViewerView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/5/24.
//

import SwiftUI

struct ImageViewerView: View {
    
    @StateObject var pdfNetworkManager = PDFNetworkManager()
    @State private var showActivityViewController = false
    
    let url: String!
    let title: String!
    
    @Binding var nextPosition : Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            VStack {
                WebImageView(imageUrl: url)
                    .frame(maxWidth: .infinity)
                    .frame(height: 600)
                    .cornerRadius(12)
                    .padding(.top,30)
                
                
                Divider()
                
                saveButtonView
                    .padding(.leading,25)
                    .padding(.bottom,30)
            }
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: title))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        .sheet(isPresented: $showActivityViewController) {
            ActivityViewController(activityItems: [pdfNetworkManager.pdfData!])
                }
        
    }
    
    var saveButtonView: some View {
        
        HStack {
            
            Button(action: {
                
                pdfNetworkManager.downloadPDF(urlString: url)
                
            }) {
                HStack {
                    
                    Text("Download Image")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(.white)
     
                }
                
                
                
            }
            .onChange(of: pdfNetworkManager.pdfData) { newData in
                if let data = newData {
                     pdfNetworkManager.saveImageToFilesApp(data: data, fileName: "lecture") { success in
                        if success {
                            showActivityViewController = true
                        } else {
                            print("Failed to save PDF.")
                        }
                    }
                }
            }
            .frame(width: 156, height: 45)
            .background(hexToColor(hex: "#007D40"))
            .cornerRadius(22)
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
            }
            
            Spacer()
            
            HStack {
                Text("Next")
                    .font(.custom(FONT_SEMIBOLD, size: 16))
                    .foregroundColor(hexToColor(hex: "#007D40"))
                
                Image(isRTL ? "ic_next_ar"  : "ic_next")
                    .resizable()
                    .frame(width: 20,height: 20)
            }
            .onTapGesture {
                nextPosition = nextPosition + 1
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.trailing,25)
        }
        .padding(.top)
    }
}

