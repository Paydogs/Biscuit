//
//  AppStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

class AppStore: BaseStore<AppState> {
    override func handleAction(action: Action) {
        guard let action = action as? AppActions else { return }
        print("AppStore is handling action")
        switch action {
            case .didReceivedErrors(let error):
                handleDidReceivedErrors(errors: error)
        }
    }
}

private extension AppStore {
    func handleDidReceivedErrors(errors: [AppError]) {
        update { state in
            state.errors.append(contentsOf: errors)
        }
    }
}
