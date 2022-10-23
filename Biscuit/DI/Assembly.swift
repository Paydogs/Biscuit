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
    static let menuController = Factory(scope: .singleton, factory: { MenuController(appState: appStore.resolve().observed,
                                                                                     packetState: packetStore.resolve().observed) })
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

// MARK: - DataProviders
extension BiscuitContainer {
    static let headerViewDataProvider = Factory { HeaderViewDataProvider(appState: appStore.resolve().observed,
                                                                         packetState: packetStore.resolve().observed) }
    static let logViewDataProvider = Factory { LogViewDataProvider(appState: appStore.resolve().observed,
                                                                    packetState: packetStore.resolve().observed) }
    static let packetViewDataProvider = Factory { PacketViewDataProvider(appState: appStore.resolve().observed,
                                                                         packetState: packetStore.resolve().observed) }
}

// MARK: - EventHandlers
extension BiscuitContainer {
    static let headerViewEventHandler = Factory { HeaderViewEventHandler(appState: appStore.resolve().observed,
                                                                         packetState: packetStore.resolve().observed,
                                                                         updateFilterUseCase: updateFilterUseCase.resolve()) }
    static let logViewEventHandler = Factory { LogViewEventHandler(appState: appStore.resolve().observed,
                                                                   packetState: packetStore.resolve().observed,
                                                                   selectPacketsUseCase: selectPacketsUseCase.resolve()) }
    static let packetViewEventHandler = Factory { PacketViewEventHandler(appState: appStore.resolve().observed,
                                                                         packetState: packetStore.resolve().observed) }
}

// MARK: - Controllers
extension BiscuitContainer {
    static let headerViewController = Factory { HeaderViewController(dataProvider: headerViewDataProvider.resolve(),
                                                                     eventHandler: headerViewEventHandler.resolve()) }

    static let logViewController = Factory { LogViewController(dataProvider: logViewDataProvider.resolve(),
                                                               eventHandler: logViewEventHandler.resolve()) }

    static let packetViewController = Factory { PacketViewController(dataProvider: packetViewDataProvider.resolve(),
                                                                     eventHandler: packetViewEventHandler.resolve()) }

}

