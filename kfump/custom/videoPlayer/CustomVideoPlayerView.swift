//
//  CustomVideoPlayerView.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/6/24.
//

import SwiftUI
import AVKit
import AVFoundation


struct CustomVideoPlayerView: UIViewControllerRepresentable {
    var videoURL: URL
    @Binding var isFullScreen: Bool
    
    func makeUIViewController(context: Context) -> CustomAVPlayerViewController {
        let controller = CustomAVPlayerViewController()
        let player = AVPlayer(url: videoURL)
        controller.player = player
        controller.showsPlaybackControls = false // Hide default controls
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: CustomAVPlayerViewController, context: Context) {
        if isFullScreen {
            uiViewController.entersFullScreenWhenPlaybackBegins = true
            uiViewController.exitsFullScreenWhenPlaybackEnds = true
        } else {
            uiViewController.entersFullScreenWhenPlaybackBegins = false
            uiViewController.exitsFullScreenWhenPlaybackEnds = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        var parent: CustomVideoPlayerView
        
        init(_ parent: CustomVideoPlayerView) {
            self.parent = parent
        }
        
        func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.isFullScreen = true
        }
        
        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.isFullScreen = false
        }
    }
}
