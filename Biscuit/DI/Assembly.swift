//
//  Assembly.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Factory

class BiscuitContainer: SharedContainer { }

// MARK: - Core
extension BiscuitContainer {
    static let dispatcher = Factory(scope: .singleton, factory: { MainDispatcher() as Dispatcher })
    static let connector = Factory(scope: .shared, factory: { Connector() })
}

// MARK: - Stores
extension BiscuitContainer {
    static let messageStore = Factory(scope: .shared, factory: { MessageStore() })
}

// MARK: - UseCases
extension BiscuitContainer {
    static let postMessageUseCase = Factory { PostMessageUseCase() as PostMessageUseCaseInterface }
}

