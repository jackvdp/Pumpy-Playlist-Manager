//
//  PlayerViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import Foundation
import AVFoundation
import SwiftUI

class PlayerManager: ObservableObject {
    
    @Published var player: AVQueuePlayer?
    @Published var playerState: PlayerState = .notPlaying
    @Published var currentTrack: Track?
    @Published var currentTime: CGFloat = 0

    var queue = [Track]()
    var timer: Timer?
    var incrementTimeSlide: CGFloat = 0

    init() {
        setUpObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    func startPlaying(queue: [Track]) {
        let assets = convertTracksToAssets(queue)
        let requiredAssetKeys = [
            "playable", "tracks", "duration"
        ]
        if !assets.isEmpty {
            player = AVQueuePlayer(playerItem: AVPlayerItem(asset: assets[0],
                                                            automaticallyLoadedAssetKeys: requiredAssetKeys))
            player?.play()
            self.queue = queue
            if assets.count > 1 {
                DispatchQueue(label: "com.pumpy.audioqueue").async {
                    for i in 1...assets.count-1 {
                        assets[i].loadValuesAsynchronously(forKeys: requiredAssetKeys) {
                            let item = AVPlayerItem(asset: assets[i],
                                                    automaticallyLoadedAssetKeys: requiredAssetKeys)
                            self.player?.insert(item, after: nil)
                        }
                    }
                }
            }
        }
    }
    
    private func convertTracksToAssets(_ tracks: [Track]) -> [AVAsset] {
        let assets: [AVAsset] = tracks.compactMap { track in
            if let url = URL(string: track.previewUrl ?? "") {
                return AVAsset(url: url)
            }
            return nil
        }
        
        return assets
    }
    
}

// MARK: - Controls

extension PlayerManager {
    func playPauseMusic() {
        player?.isPlaying ?? false ? player?.pause() : player?.play()
    }
    
    func nextTrack() {
        player?.advanceToNextItem()
    }
    
    func quitPlayer() {
        player = nil
        queue = []
        currentTrack = nil
        currentTime = 0
        timer?.invalidate()
        timer = nil
    }
}


// MARK: - Notification

extension PlayerManager {
    private func setUpObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEndTrack),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changePlayState),
                                               name: AVPlayer.rateDidChangeNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(skippedTrack),
                                               name: AVPlayerItem.timeJumpedNotification,
                                               object: nil)
    }

    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.removeObserver(self, name: AVPlayer.rateDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: AVPlayerItem.timeJumpedNotification, object: nil)
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func changePlayState() {
        if player?.isPlaying ?? false {
            playerState = .playing
            setUpTimer()
        } else {
            playerState = .notPlaying
            timer?.invalidate()
            timer = nil
        }
        getTime()
    }
    
    @objc private func didEndTrack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setCurrentPlayingInfo()
        }
    }

    @objc private func skippedTrack() {
        setCurrentPlayingInfo()
    }

    private func setCurrentPlayingInfo() {
        if let url = (player?.currentItem?.asset as? AVURLAsset)?.url {
            currentTrack = queue.first(where: { track in
                track.previewUrl ?? "" == url.absoluteString
            })
        }
        getTime()
    }
    
    private func setUpTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.getTime()
        }
    }
    
    @objc private func getTime() {
        if let item = player?.currentItem {
            let duration = item.asset.duration.seconds
            let time = item.currentTime().seconds
            
            let timePercentage = time / duration
            if timePercentage < 0 || timePercentage > 1 {
                currentTime = 1
            } else {
                currentTime = timePercentage
            }
        } else {
            currentTime = 0
            currentTrack = nil
            playerState = .notPlaying
            timer?.invalidate()
            timer = nil
        }
    }

}
