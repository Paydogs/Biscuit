//
//  AppController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 28..
//

import SwiftUI
import Factory
import Combine

class AppController: ObservableObject {
    @ObservedObject var packetState: Observed<PacketState>
    private var subscriptions: Set<AnyCancellable> = []

    init(packetState: Observed<PacketState>) {
        self.packetState = packetState
    }
}
