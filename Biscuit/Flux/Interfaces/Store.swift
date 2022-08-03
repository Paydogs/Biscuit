//
//  Store.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import Foundation

protocol Store {
    associatedtype IncludedState: State
    func reduce(action: Action)
}
