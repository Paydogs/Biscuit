//
//  BagelPacketParser.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 25..
//

import Foundation

struct BagelPacketParser {
    func parseData(_ data: Data) -> BagelPacket? {
//        let cleaned = data.removeFirstBytes(8)
//        let cleanedString = String(data: cleaned, encoding: .utf8)
//        if cleanedString == nil {
//            print("This is a fucky string")
//            let d = data as NSData
//            print("FUCK: \(d)")
//        }
        return parseBody(data: data)
    }
}

// MARK: - Data processing
private extension BagelPacketParser {
    func parseBody(data: Data) -> BagelPacket? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970

        do {
            let bagelPacket = try jsonDecoder.decode(BagelPacket.self, from: data)
//            describePacket(packet: bagelPacket)
            return bagelPacket

        } catch {
            print(error)
            return nil
        }
    }

    func describePacket(packet: BagelPacket) {
        DispatchQueue.global(qos: .background).async {
        print("\n====================")
        print("[Describe packet][\(packet.packetId)] url: \(packet.requestInfo?.url)")
        print("[Describe packet][\(packet.packetId)] statusCode: \(packet.requestInfo?.statusCode)")
        print("[Describe packet][\(packet.packetId)] device: \(packet.device?.deviceName)")
        print("[Describe packet][\(packet.packetId)] request: \(packet.requestInfo?.requestBody)")
        print("[Describe packet][\(packet.packetId)] response: \(packet.requestInfo?.responseData)")
        print("====================\n")
        }
    }
}
