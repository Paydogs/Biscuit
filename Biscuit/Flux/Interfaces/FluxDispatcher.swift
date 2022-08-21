//
//  FluxDispatcher.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

protocol FluxDispatcher: AutoMockable {
    func registerStore(store: FluxStore)
    
    func dispatch(action: FluxAction)
}
