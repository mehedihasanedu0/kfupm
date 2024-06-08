//
//  VideoPlayerView.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/5/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoContainerView: View {
    
    @StateObject private var viewModel = VideoPlayerViewModel()
    let videoURL : URL!
    @State private var isFullScreen: Bool = false
    
    @StateObject var pdfNetworkManager = PDFNetworkManager()
    @State private var showActivityViewController = false
    
    let url: String!
    let title: String!
    let description: String!
    
    @Binding var nextPosition : Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            
            //            VideoPlayerControlsView(videoURL: videoURL, isFullScreen: $isFullScreen)
            
            //            VideoPlayerControlsView(viewModel: viewModel)
            ScrollView {
                VStack {
                    
                    VideoPlayerView(videoURL: videoURL)
                        .onAppear {
                            let player = AVPlayer(url: videoURL)
                            viewModel.setPlayer(player)
//                            player.play()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .frame(height: 215)
                        .cornerRadius(12)
                        
                    
                    Text(description)
                        .font(.custom(FONT_LIGHT, size: 15))
                        .padding(.top)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    saveButtonView
                        .padding(.leading,25)
                        .padding(.bottom,30)
                }
            }
            
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: title))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
        
    }
    
    var saveButtonView: some View {
        
        HStack {
            
            Button(action: {
//                pdfNetworkManager.downloadVideo(from: url)
                pdfNetworkManager.downloadAndSaveVideo(from: URL(string: url)!)
                
            }) {
                HStack {
                    
                    Text("Download Video")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(.white)
                    
                }
                
            }
//            .onChange(of: pdfNetworkManager.videoData) { newData in
//                if let data = newData {
//                    pdfNetworkManager.saveVideo(data: data) { success in
//                        if success {
//                            if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                                directory.appendingPathComponent("Video.mp4")
//                            }
//                        } else {
//                            print("Failed to save video.")
//                        }
//                    }
//                }
//            }
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


//#Preview {
//    VideoPlayerView()
//}
