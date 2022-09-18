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
    static let connector = Factory(scope: .shared, factory: { Connector() })
    static let appController = Factory(scope: .shared, factory: { AppController(packetState: packetStore.resolve().observed) })
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

// MARK: - DataProviders
extension BiscuitContainer {
    static let headerAreaDataProvider = Factory { HeaderAreaDataProvider(appState: BiscuitContainer.appStore.resolve().observed,
                                                                     packetState: BiscuitContainer.packetStore.resolve().observed) }
    static let logAreaDataProvider = Factory { LogAreaDataProvider(appState: BiscuitContainer.appStore.resolve().observed,
                                                                   packetState: BiscuitContainer.packetStore.resolve().observed) }
}

// MARK: - EventHandlers
extension BiscuitContainer {
    static let headerAreaEventHandler = Factory { HeaderAreaEventHandler(appState: BiscuitContainer.appStore.resolve().observed,
                                                                         packetState: BiscuitContainer.packetStore.resolve().observed,
                                                                         selectProjectUseCase: BiscuitContainer.selectProjectUseCase.resolve(),
                                                                         selectDeviceUseCase: BiscuitContainer.selectDeviceUseCase.resolve())}
    static let logAreaEventHandler = Factory { LogAreaEventHandler()}
}

// MARK: - Controllers
extension BiscuitContainer {
    static let headerAreaController = Factory { HeaderAreaController(dataProvider: BiscuitContainer.headerAreaDataProvider.resolve(),
                                                                     eventHandler: BiscuitContainer.headerAreaEventHandler.resolve()) }

    static let logAreaController = Factory { LogAreaController(dataProvider: BiscuitContainer.logAreaDataProvider.resolve(),
                                                               eventHandler: BiscuitContainer.logAreaEventHandler.resolve()) }
}

