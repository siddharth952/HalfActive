//
//  AppContainer.swift
//  HalfActive
//
//  Created by Siddharth S on 14/06/25.
//

import Swinject

final class AppContainer {
    static let shared = AppContainer()

    let container: Container = {
        let container = Container()

        container.register(AudioPlayerServiceProtocol.self) { _ in
            AudioPlayerService()
        }

        container.register(NotificationViewModel.self) { resolver in
            let audioService = resolver.resolve(AudioPlayerServiceProtocol.self)!
            return NotificationViewModel(audioService: audioService)
        }

        container.register(NotificationHandler.self) { resolver in
            let viewModel = resolver.resolve(NotificationViewModel.self)!
            return NotificationHandler(viewModel: viewModel)
        }

        return container
    }()
}
