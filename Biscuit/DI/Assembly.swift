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
    static let connector = Factory(scope: .singleton, factory: { Connector() })
    static let menuController = Factory(scope: .singleton, factory: { MenuController() })
}

// MARK: - Stores
extension BiscuitContainer {
    static let appStore = Factory(scope: .singleton, factory: { AppStore(state: AppState.defaultValue()) })
    static let packetStore = Factory(scope: .singleton, factory: { PacketStore(state: PacketState.defaultValue()) })
}

// MARK: - UseCases
extension BiscuitContainer {
    static let postAppErrorUseCase = Factory { PostAppErrorUseCase() as PostAppErrorUseCaseInterface }
    static let storePacketUseCase = Factory { StorePacketUseCase() as StorePacketUseCaseInterface }
    static let postInvalidPacketUseCase = Factory { PostInvalidPacketUseCase() as PostInvalidPacketUseCaseInterface }
    static let clientConnectedUseCase = Factory { ClientConnectedUseCase() as ClientConnectedUseCaseInterface }
    static let clientDisconnectedUseCase = Factory { ClientDisconnectedUseCase() as ClientDisconnectedUseCaseInterface }
    static let selectPacketsUseCase = Factory { SelectPacketsUseCase() as SelectPacketsUseCaseInterface }
    static let updateFilterUseCase = Factory { UpdateFilterUseCase() as UpdateFilterUseCaseInterface }
}

