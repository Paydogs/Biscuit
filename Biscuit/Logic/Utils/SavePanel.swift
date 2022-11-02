//
//  SavePanel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 23..
//

import AppKit

struct SavePanel {
    static func exportPackets(packets: [Packet]) {
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

private extension SavePanel {
    static func showPacketExportPanel(proposedName: String?) -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.json]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.title = Localized.SavePanel.exportpacketTitle
        savePanel.message = Localized.SavePanel.exportpacketMessage
        savePanel.nameFieldLabel = Localized.SavePanel.exportpacketNamefield
        if let proposedName = proposedName {
            savePanel.nameFieldStringValue = proposedName
        }

        let response = savePanel.runModal()
        return response == .OK ? savePanel.url : nil
    }
}
