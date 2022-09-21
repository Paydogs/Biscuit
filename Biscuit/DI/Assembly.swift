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
    static let updateFilterUseCase = Factory { UpdateFilterUseCase() as UpdateFilterUseCaseInterface }
}

// MARK: - DataProviders
extension BiscuitContainer {
    static let headerViewDataProvider = Factory { HeaderViewDataProvider(appState: BiscuitContainer.appStore.resolve().observed,
                                                                         packetState: BiscuitContainer.packetStore.resolve().observed) }
    static let logViewEventProvider = Factory { LogViewDataProvider(appState: BiscuitContainer.appStore.resolve().observed,
                                                                    packetState: BiscuitContainer.packetStore.resolve().observed) }
}

// MARK: - EventHandlers
extension BiscuitContainer {
    static let headerViewEventHandler = Factory { HeaderViewEventHandler(appState: BiscuitContainer.appStore.resolve().observed,
                                                                         packetState: BiscuitContainer.packetStore.resolve().observed,
                                                                         selectProjectUseCase: BiscuitContainer.selectProjectUseCase.resolve(),
                                                                         selectDeviceUseCase: BiscuitContainer.selectDeviceUseCase.resolve(),
                                                                         updateFilterUseCase: BiscuitContainer.updateFilterUseCase.resolve()) }
    static let logViewEventHandler = Factory { LogViewEventHandler()}
}

// MARK: - Controllers
extension BiscuitContainer {
    static let headerViewController = Factory { HeaderViewController(dataProvider: BiscuitContainer.headerViewDataProvider.resolve(),
                                                                     eventHandler: BiscuitContainer.headerViewEventHandler.resolve()) }

    static let logViewController = Factory { LogViewController(dataProvider: BiscuitContainer.logViewEventProvider.resolve(),
                                                               eventHandler: BiscuitContainer.logViewEventHandler.resolve()) }
}

