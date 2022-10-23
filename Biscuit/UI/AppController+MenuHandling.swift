//
//  AppController+MenuHandling.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 23..
//

import AppKit
struct MenuHandler { }

extension AppController {
    func exportPackets(packets: [Packet]) {
        for packet in packets {
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
        savePanel.title = Localizable.SavePanel.exportpacketTitle
        savePanel.message = Localizable.SavePanel.exportpacketMessage
        savePanel.nameFieldLabel = Localizable.SavePanel.exportpacketNamefield
        if let proposedName = proposedName {
            savePanel.nameFieldStringValue = proposedName
        }

        let response = savePanel.runModal()
        return response == .OK ? savePanel.url : nil
    }
}
