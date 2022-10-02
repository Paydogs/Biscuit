//
//  PacketViewController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import SwiftUI
import Factory
import Combine

class PacketViewController {
    @ObservedObject var domain: PacketViewDomain

    var dataProvider: PacketViewDataProvider
    var eventHandler: PacketViewEventHandling

    init(dataProvider: PacketViewDataProvider,
         eventHandler: PacketViewEventHandling) {
        self.dataProvider = dataProvider
        self.eventHandler = eventHandler
        domain = dataProvider.domain
    }
}