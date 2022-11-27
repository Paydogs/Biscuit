//
//  SavePanel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 23..
//

import AppKit
import Factory
import ZIPFoundation

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
            let filePath = showPacketExportPanelForJson(proposedName: proposedName)
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

    static func exportPacketAsZip(packets: [Packet]) {
        var bodylessPackets: [Packet] = []
        var packetsWithBody: [Packet] = []
        for packet in packets {
            if packet.response.prettyBody == nil { bodylessPackets.append(packet) }
            else { packetsWithBody.append(packet)}
        }

        let filePath = showPacketExportPanelForArchive(proposedName: "Archive.zip")
        guard let filePath = filePath else { return }

        guard let archive = Archive(accessMode: .create) else  { return }

        for packet in packetsWithBody {
            guard let body = packet.response.prettyBody else { return }

            let proposedFileName = "\(URL(string: packet.url)?.lastPathComponent ?? "") - \(packet.startDate.formatted(.iso8601)).json"
            guard let data = body.data(using: NSUTF8StringEncoding) else { return }
            do {
                try archive.addEntry(with: proposedFileName, type: .file, uncompressedSize: Int64(data.count), provider: { (position: Int64, size: Int) in
                    let rangeStart = Int(position)
                    let rangeEnd = Int(position + Int64(size))
                    return data.subdata(in: rangeStart..<rangeEnd)
                })
//                try archive.addEntry(with: proposedFileName, type: .file, uncompressedSize: UInt32(data.count), bufferSize: 4, provider: { (position, size) -> Data in
//                    return data.subdata(in: position..<position+size)
//                })
            } catch {
                print(error.localizedDescription)
            }
        }

        let archiveData = archive.data
        do {
            try archiveData?.write(to: filePath)
        } catch {
            print(error.localizedDescription)
        }

        if !bodylessPackets.isEmpty {
            let postMessageTask = BiscuitContainer.postMessageTask.callAsFunction()
            postMessageTask.execute(message: Localized.Messages.Export.emptyBodyForPackets(bodylessPackets.count))
        }
    }
}

private extension SavePanel {
    static func showPacketExportPanelForJson(proposedName: String?) -> URL? {
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

    static func showPacketExportPanelForArchive(proposedName: String?) -> URL? {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.archive]
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
