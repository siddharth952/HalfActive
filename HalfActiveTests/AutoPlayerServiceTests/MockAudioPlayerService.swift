//
//  AudioPlayerServiceMock.swift
//  HalfActive
//
//  Created by Siddharth S on 15/06/25.
//

import Foundation
import AVFoundation

final class MockAudioPlayerService: AudioPlayerServiceProtocol {
    var player: AVAudioPlayer?
    
    var playSoundCalled =  false
    var receivedSoundName: String?
    var receivedVolume:    Float?
    var receivedLoop:      Bool?
    
    func playSound(named: String, volume: Float, loop: Bool) {
        playSoundCalled = true
        
        receivedSoundName = named
        receivedVolume = volume
        receivedLoop = loop
    }
    
    func stop() {
        
    }
}
