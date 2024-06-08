//
//  VideoPlayerViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/6/24.
//

import SwiftUI
import AVKit
import AVFoundation

class VideoPlayerViewModel: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var currentTime: CMTime = .zero
    @Published var duration: CMTime = .zero
    @Published var isMuted: Bool = false
    private var player: AVPlayer?
    private var timeObserver: Any?
    
    func setPlayer(_ player: AVPlayer) {
        self.player = player
        self.duration = player.currentItem?.duration ?? .zero
        self.timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] time in
            self?.currentTime = time
            self?.duration = self?.player?.currentItem?.duration ?? .zero
        }
    }
    
    func playPause() {
        guard let player = player else { return }
        if player.timeControlStatus == .playing {
            player.pause()
        } else {
            player.play()
        }
        isPlaying = player.timeControlStatus == .playing
    }
    
    func seek(to seconds: Double) {
        guard let player = player else { return }
        let newTime = CMTime(seconds: seconds, preferredTimescale: 1)
        player.seek(to: newTime)
    }
    
    func toggleMute() {
        guard let player = player else { return }
        player.isMuted.toggle()
        isMuted = player.isMuted
    }
}

