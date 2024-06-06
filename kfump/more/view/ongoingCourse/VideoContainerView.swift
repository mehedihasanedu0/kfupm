//
//  VideoPlayerView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/5/24.
//

import SwiftUI

struct VideoContainerView: View {
    @StateObject var pdfNetworkManager = PDFNetworkManager()
    @State private var showActivityViewController = false
    
    let url: String!
    let title: String!
    var body: some View {
        
        ZStack {
            VStack {
                
                
                
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
            ActivityViewController(activityItems: [pdfNetworkManager.videoData!])
                }
        
    }
    
    var saveButtonView: some View {
        
        HStack {
            
            Button(action: {
                pdfNetworkManager.downloadVideo(from: url)
                
            }) {
                HStack {
                    
                    Text("Download Video")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(.white)
     
                }
                
            }
            .onChange(of: pdfNetworkManager.videoData) { newData in
                if let data = newData {
                    pdfNetworkManager.saveVideo(data: data) { success in
                        if success {
                            if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                                directory.appendingPathComponent("Video.mp4")
                            }
                        } else {
                            print("Failed to save video.")
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
            .padding(.trailing,25)
        }
        .padding(.top)
    }
}


//#Preview {
//    VideoPlayerView()
//}
