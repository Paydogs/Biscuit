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
    static let dispatcher = Factory(scope: .singleton, factory: { MainDispatcher() as FluxDispatcher })
    static let core = Factory(scope: .singleton, factory: { BiscuitCore() })
    static let connector = Factory(scope: .singleton, factory: { GrandCentralConnector() })
    static let menuController = Factory(scope: .singleton, factory: { MenuController() })
}

// MARK: - Stores
extension BiscuitContainer {
    static let appStore = Factory(scope: .singleton, factory: { AppStore(state: AppState.defaultValue()) })
    static let packetStore = Factory(scope: .singleton, factory: { PacketStore(state: PacketState.defaultValue()) })
}

// MARK: - Tasks
extension BiscuitContainer {
    static let postMessageTask = Factory { PostMessageTask() as PostMessageTaskInterface }
}

