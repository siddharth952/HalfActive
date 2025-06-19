//
//  NotificationViewModel.swift
//  HalfActive
//
//  Created by Siddharth S on 14/06/25.
//

import Foundation

final class NotificationViewModel {
    private let audioService: AudioPlayerServiceProtocol
    
    init(audioService: AudioPlayerServiceProtocol) {
        self.audioService = audioService
    }
    
    func handleNoti(userInfo: [AnyHashable: Any]) {
        if let playSound = userInfo["playSound"] as? Bool, playSound {
            audioService.playSound(named: "test_sound_file", volume: 0.4, loop: false)
        }
    }
}
