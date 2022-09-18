//
//  LogAreaController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 12..
//

import SwiftUI
import Factory
import Combine

class LogAreaController {
    @ObservedObject var domain: LogAreaDomain

    var dataProvider: LogAreaDataProvider
    var eventHandler: LogAreaEventHandling

    init(dataProvider: LogAreaDataProvider,
         eventHandler: LogAreaEventHandling) {
        self.dataProvider = dataProvider
        self.eventHandler = eventHandler
        domain = dataProvider.domain
    }
}
