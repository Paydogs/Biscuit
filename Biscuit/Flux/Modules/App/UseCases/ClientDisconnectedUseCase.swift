//
//  ClientDisconnectedUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

import Factory

struct ClientDisconnectedUseCase: ClientDisconnectedUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher
    @Injected(BiscuitContainer.appStore) private var appStore

    func execute(clientId: String) {
        print("[ClientDisconnectedUseCase] sending action")
        if let client = appStore.observed.state.connectedClients.first(where: { (client: Client) in
            client.id == clientId
        }) {
            let action: AppActions = .didDisconnectClient(client)
            dispatcher.dispatch(action: action)
        }

    }
}
