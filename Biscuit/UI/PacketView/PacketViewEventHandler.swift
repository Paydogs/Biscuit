//
//  PacketViewEventHandler.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Foundation
import AppKit

protocol PacketViewEventHandling {
    func copyBodyToClipboard(packet: Packet?)
}

struct PacketViewEventHandler {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState
    }
}

extension PacketViewEventHandler: PacketViewEventHandling {
    func copyBodyToClipboard(packet: Packet?) {
        if let prettyBody = packet?.response.prettyBody {
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([.string], owner: nil)
            pasteboard.setString(String(prettyBody), forType: .string)
        }
    }
}
