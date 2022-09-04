//
//  ClientConnectedUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 21..
//

import Factory

struct ClientConnectedUseCase: ClientConnectedUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(client: Client) {
        print("[ClientConnectedUseCase] sending action")
        let action: AppActions = .didConnectClient(client)
        dispatcher.dispatch(action: action)
    }
}
