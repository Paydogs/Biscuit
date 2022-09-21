//
//  HeaderViewController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI
import Factory
import Combine

class HeaderViewController {
    @ObservedObject var domain: HeaderViewDomain

    var dataProvider: HeaderViewDataProvider
    var eventHandler: HeaderViewEventHandling

    init(dataProvider: HeaderViewDataProvider,
         eventHandler: HeaderViewEventHandling) {
        self.dataProvider = dataProvider
        self.eventHandler = eventHandler
        domain = dataProvider.domain
    }
}
