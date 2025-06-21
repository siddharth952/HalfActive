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
            audioService.playSound(named: "bubble-sound", volume: 0.9, loop: false)
        }
    }
}
