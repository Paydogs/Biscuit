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
    var dataProvider: HeaderViewDataProvider
    var eventHandler: HeaderViewEventHandling

    init(dataProvider: HeaderViewDataProvider,
         eventHandler: HeaderViewEventHandling) {
        self.dataProvider = dataProvider
        self.eventHandler = eventHandler
    }
}
