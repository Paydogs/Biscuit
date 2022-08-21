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
            case .setActiveConnectionCount(let count):
                handleSetActiveConnectionCount(count: count)
            case .didReceivedErrors(let error):
                handleDidReceivedErrors(errors: error)
        }
    }
}

private extension AppStore {
    func handleSetActiveConnectionCount(count: Int) {
        update { state in
            state.activeConnections = count
        }
    }

    func handleDidReceivedErrors(errors: [AppError]) {
        update { state in
            state.errors.append(contentsOf: errors)
        }
    }
}
