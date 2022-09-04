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
}

// MARK: - UseCases
extension BiscuitContainer {
    static let postAppErrorUseCase = Factory { PostAppErrorUseCase() as PostAppErrorUseCaseInterface }
    static let storePacketUseCase = Factory { StorePacketUseCase() as StorePacketUseCaseInterface }
    static let clientConnectedUseCase = Factory { ClientConnectedUseCase() as ClientConnectedUseCaseInterface }
    static let clientDisconnectedUseCase = Factory { ClientDisconnectedUseCase() as ClientDisconnectedUseCaseInterface }
    static let selectProjectUseCase = Factory { SelectProjectUseCase() as SelectProjectUseCaseInterface }
    static let selectDeviceUseCase = Factory { SelectDeviceUseCase() as SelectDeviceUseCaseInterface }
}

extension BiscuitContainer {
    static let headerController = Factory { HeaderController(appState: BiscuitContainer.appStore.resolve().observed,
                                                             packetState: BiscuitContainer.packetStore.resolve().observed,
                                                             selectProjectUseCase: BiscuitContainer.selectProjectUseCase.resolve(),
                                                             selectDeviceUseCase: BiscuitContainer.selectDeviceUseCase.resolve()) }
}

