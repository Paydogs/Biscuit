//
//  BagelPacketParser.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 25..
//

import Foundation

struct BagelPacketParser {
    func parseData(_ data: Data) -> BagelPacket? {
        let cleaned = data.removeFirstBytes(8)
        return parseBody(data: cleaned)
    }
}

// MARK: - Data processing
private extension BagelPacketParser {
    func parseBody(data: Data) -> BagelPacket? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970

        do {
            let bagelPacket = try jsonDecoder.decode(BagelPacket.self, from: data)
            return bagelPacket

        } catch {
            print(error)
            return nil
        }
    }
}
