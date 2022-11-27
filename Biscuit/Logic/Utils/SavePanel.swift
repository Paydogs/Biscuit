//
//  SavePanel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 23..
//

import AppKit
import Factory

struct SavePanel {
    static func exportPacketBodies(packets: [Packet]) {
        var bodylessPackets: [Packet] = []
        var packetsWithBody: [Packet] = []
        for packet in packets {
            if packet.response.prettyBody == nil { bodylessPackets.append(packet) }
            else { packetsWithBody.append(packet)}
        }

        for packet in packetsWithBody {
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
        if !bodylessPackets.isEmpty {
            let postMessageTask = BiscuitContainer.postMessageTask.callAsFunction()
            postMessageTask.execute(message: Localized.Messages.Export.emptyBodyForPackets(bodylessPackets.count))
        }
    }
}

private extension SavePanel {
    static func showPacketExportPanel(proposedName: String?) -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.json]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.title = Localized.SavePanel.Exportpacket.title
        savePanel.message = Localized.SavePanel.Exportpacket.message
        savePanel.nameFieldLabel = Localized.SavePanel.Exportpacket.namefield
        if let proposedName = proposedName {
            savePanel.nameFieldStringValue = proposedName
        }

        let response = savePanel.runModal()
        return response == .OK ? savePanel.url : nil
    }
}
