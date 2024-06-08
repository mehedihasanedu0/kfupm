//
//  CustomAVPlayerViewController.swift
//  kfump
//
//  Created by Mehedi Hasan on 6/6/24.
//

import SwiftUI
import AVKit
import AVFoundation


class CustomAVPlayerViewController: AVPlayerViewController {
    
    
    private var customSlider: UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        hideDefaultSlider()
//        addCustomSlider()
    }
    
    private func customizeProgressView() {
        guard let playerView = contentOverlayView?.superview?.subviews.first(where: { $0 is UISlider }) as? UISlider else {
            return
        }
        playerView.tintColor = hexToColor(hex: "#007D40")
        playerView.backgroundColor = UIColor.gray
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    private func hideDefaultSlider() {
        guard let playerView = contentOverlayView?.superview else { return }
        let allSliders = findSubviews(ofType: UISlider.self, in: playerView)
        for slider in allSliders {
            slider.isHidden = true
            print("hideDefaultSlider ")
        }
    }
    
    private func findSubviews<T: UIView>(ofType type: T.Type, in view: UIView) -> [T] {
        var result: [T] = []
        for subview in view.subviews {
            if let subview = subview as? T {
                result.append(subview)
            } else {
                result.append(contentsOf: findSubviews(ofType: type, in: subview))
            }
        }
        return result
    }
    
    private func addCustomSlider() {
        guard let playerView = contentOverlayView?.superview else { return }
        if let existingSlider = customSlider {
            existingSlider.removeFromSuperview()
        }
        
        customSlider = UISlider()
        guard let customSlider = customSlider else { return }
        
        customSlider.translatesAutoresizingMaskIntoConstraints = false
        customSlider.translatesAutoresizingMaskIntoConstraints = false
        customSlider.minimumTrackTintColor = hexToColor(hex: "#007D40")
        customSlider.maximumTrackTintColor = UIColor.gray
        customSlider.thumbTintColor = UIColor.clear
        customSlider.backgroundColor = UIColor.clear
        
        
        playerView.addSubview(customSlider)
        
        NSLayoutConstraint.activate([
            customSlider.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 8),
            customSlider.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -8),
            customSlider.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -15)
        ])
        
        customSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        // Sync the slider with the current playback time
        addPeriodicTimeObserver()
    }
    
    private func addPeriodicTimeObserver() {
        let timeInterval = CMTime(seconds: 1.0, preferredTimescale: 1)
        player?.addPeriodicTimeObserver(forInterval: timeInterval, queue: .main) { [weak self] time in
            guard let duration = self?.player?.currentItem?.duration else { return }
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds(duration)
            self?.customSlider?.value = Float(currentTime / totalTime)
        }
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        guard let duration = player?.currentItem?.duration else { return }
        let totalTime = CMTimeGetSeconds(duration)
        let seekTime = totalTime * Float64(sender.value)
        let seekCMTime = CMTime(seconds: seekTime, preferredTimescale: 1)
        player?.seek(to: seekCMTime)
    }
    
    
}
