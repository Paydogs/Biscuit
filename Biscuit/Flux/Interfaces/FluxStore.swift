//
//  FluxStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import Foundation

protocol FluxStore: AutoMockable {
    func handleAction(action: FluxAction)
}
