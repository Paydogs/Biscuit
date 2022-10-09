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
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private var subscriptions: Set<AnyCancellable> = []

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>) {
        self.appState = appState
        self.packetState = packetState
    }
}

extension AppController {
    func exportPackets() {
        for packet in appState.state.selectedPackets {
            guard let body = packet.response.prettyBody else { return }

            let proposedName = URL(string: packet.url)?.lastPathComponent
            let filePath = showPacketExportPanel(proposedName: proposedName)
            if let filePath = filePath {
                do {
                    try String(body).write(to: filePath, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: filePath)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

private extension AppController {
    func showPacketExportPanel(proposedName: String?) -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.json]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.title = "Save packet"
        savePanel.message = "Choose a folder and a name to store the packet."
        savePanel.nameFieldLabel = "Packet file name:"
        if let proposedName = proposedName {
            savePanel.nameFieldStringValue = proposedName
        }

        let response = savePanel.runModal()
        return response == .OK ? savePanel.url : nil
    }
}
