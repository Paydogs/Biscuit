//
//  SelectDeviceUseCase.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import Factory

struct SelectDeviceUseCase: SelectDeviceUseCaseInterface {
    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func execute(device: Device?) {
        print("[SelectDeviceUseCase] sending action")
        let action: AppActions = .didSelectDevice(device)
        dispatcher.dispatch(action: action)
    }
}
