//
//  Assembly.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Factory

// MARK: - Core
extension Container {
    static let dispatcher = Factory(scope: .singleton, factory: { MainDispatcher() as Dispatcher })
    static let connector = Factory(scope: .shared, factory: { Connector() })
}

// MARK: - Stores
extension Container {
    static let messageStore = Factory(scope: .shared, factory: { MessageStore() })
}

// MARK: - UseCases
extension Container {
    static let postMessageUseCase = Factory { PostMessageUseCase() as PostMessageUseCaseInterface }
}

