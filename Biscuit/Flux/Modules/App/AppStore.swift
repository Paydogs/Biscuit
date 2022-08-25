//
//  AppStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

class AppStore: BaseStore<AppState> {
    override func handleAction(action: FluxAction) {
        guard let action = action as? AppActions else { return }
        print("[AppStore] AppStore is handling action")
        switch action {
            case .didConnectClient(let client):
                handleDidConnectClient(client: client)
            case .didDisconnectClient(let client):
                handleDidDisconnectClient(client: client)
            case .didReceivedErrors(let error):
                handleDidReceivedErrors(errors: error)
        }
    }
}

private extension AppStore {
    func handleDidConnectClient(client: Client) {
        update { state in
            state.connectedClients.append(client)
        }
    }

    func handleDidDisconnectClient(client: Client) {
        update { state in
            state.connectedClients.removeAll(where: { (connectedClient: Client) in connectedClient == client })
        }
    }

    func handleDidReceivedErrors(errors: [AppError]) {
        update { state in
            state.errors.append(contentsOf: errors)
        }
    }
}
