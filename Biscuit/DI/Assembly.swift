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
    static let connector = Factory(scope: .shared, factory: { Connector() })
}

// MARK: - Stores
extension BiscuitContainer {
    static let appStore = Factory(scope: .shared, factory: { AppStore(state: AppState.defaultValue()) })
    static let packetStore = Factory(scope: .shared, factory: { PacketStore(state: PacketState.defaultValue()) })
    static let testStore = Factory(scope: .shared, factory: { TestStore(state: TestState.defaultValue()) })
}

// MARK: - UseCases
extension BiscuitContainer {
    static let postAppErrorUseCase = Factory { PostAppErrorUseCase() as PostAppErrorUseCaseInterface }
    static let storePacketUseCase = Factory { StorePacketUseCase() as StorePacketUseCaseInterface }
    static let changeValueUseCase = Factory { ChangeValueUseCase() as ChangeValueUseCaseInterface }
    static let setActiveConnectionCountUseCase = Factory { SetActiveConnectionCountUseCase() as SetActiveConnectionCountUseCaseInterface }
}

