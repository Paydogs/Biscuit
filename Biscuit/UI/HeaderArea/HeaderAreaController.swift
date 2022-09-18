//
//  HeaderAreaController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI
import Factory
import Combine

class HeaderAreaController {
    @ObservedObject var domain: HeaderAreaDomain

    var dataProvider: HeaderAreaDataProvider
    var eventHandler: HeaderAreaEventHandling

    init(dataProvider: HeaderAreaDataProvider,
         eventHandler: HeaderAreaEventHandling) {
        self.dataProvider = dataProvider
        self.eventHandler = eventHandler
        domain = dataProvider.domain
    }
}
