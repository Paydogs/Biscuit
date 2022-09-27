//
//  LogViewController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 12..
//

import SwiftUI
import Factory
import Combine

class LogViewController {
    @ObservedObject var domain: LogViewDomain

    var dataProvider: LogViewDataProvider
    var eventHandler: LogViewEventHandling

    init(dataProvider: LogViewDataProvider,
         eventHandler: LogViewEventHandling) {
        self.dataProvider = dataProvider
        self.eventHandler = eventHandler
        domain = dataProvider.domain
    }
}
