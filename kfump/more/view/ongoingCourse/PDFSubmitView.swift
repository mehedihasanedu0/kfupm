//
//  PDFSubmitView.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/6/24.
//

import SwiftUI

struct PDFSubmitView: View {
    
    @State private var isHovered = false
    let url: String!
    
    var body: some View {
        
        ZStack {
            VStack {
                PDFViewWrapper(url: URL(string: url)!)
                    .edgesIgnoringSafeArea(.all)
                
                
                uploadView
                
                submitButtonView
                    .padding(.top,10)
                    .padding(.bottom,20)
            }
        }
    
        .background(isHovered ? Color.gray.opacity(0.1) : Color.clear)
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Assignment Submit"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)

    }
    
    var uploadView: some View {
        VStack {
            Text("Submit Assignment")
                .font(.custom(FONT_SEMIBOLD, size: 18))
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundColor(.black)
                .padding(.horizontal,20)
                
            
            VStack {
                Image("ic_file_upload")
                    .font(.system(size: 50))
                    .foregroundColor(.yellow)
                    .padding(.bottom, 10)
                
                Text("Select a file to upload")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("or drag and drop it here")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 165)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundColor(hexToColor(hex: "#E5E5D9"))
            )
            .onHover { hovering in
                isHovered = hovering
            }
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
    
    var submitButtonView: some View {
        
        HStack {
            
            Button(action: {
                
            }) {
                HStack {
                    Text("Submit")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(hexToColor(hex: "#007D40"))
     
                }
                
            }
            .frame(width: 100, height: 45)
            .background(.white)
            .cornerRadius(22)
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
            }
            .padding(.leading,25)
            
            Spacer()
            
            HStack {
                Text("Next")
                    .font(.custom(FONT_SEMIBOLD, size: 16))
                    .foregroundColor(hexToColor(hex: "#007D40"))
                
                Image(isRTL ? "ic_next_ar"  : "ic_next")
                    .resizable()
                    .frame(width: 20,height: 20)
            }
            .padding(.trailing,25)
        }
        .padding(.top)
    }
}

//#Preview {
//    PDFSubmitView()
//}

//struct FileUploadView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFSubmitView()
//            .frame(width: 300, height: 200)
//    }
//}
