//
//  Dispatcher.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import Foundation

protocol Dispatcher: AutoMockable {
    func registerStore(store: Store)
    
    func dispatch(action: Action)
}