//
//  NotificationManager.swift
//  HalfActive
//
//  Created by Siddharth S on 14/06/25.
//

import Foundation
import UserNotifications

final class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    private let viewModel: NotificationViewModel
    
    init(viewModel: NotificationViewModel) {
        self.viewModel = viewModel
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        viewModel.handleNoti(userInfo: notification.request.content.userInfo)
        completionHandler([.banner, .sound])
    }
    
}
