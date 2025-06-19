//
//  AudioPlayerService.swift
//  HalfActive
//
//  Created by Siddharth S on 14/06/25.
//

import AVFoundation

protocol AudioPlayerServiceProtocol {
    var player: AVAudioPlayer? { get set }
    func playSound(named: String, volume: Float, loop: Bool)
    func stop()
}

final class AudioPlayerService: AudioPlayerServiceProtocol {
    internal var player: AVAudioPlayer?
    
    func playSound(named: String, volume: Float, loop: Bool) {
        guard let url = Bundle.main.url(forResource: named,
                                        withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = volume
            player?.numberOfLoops = loop ? -1 : 0
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Failed to play!")
        }
    }
    
    func stop() {
        player?.stop()
    }
    
}
