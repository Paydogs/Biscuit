//
//  Device.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct DeviceDescriptor: Equatable, Hashable {
    var deviceId: String
    var name: String
    var description: String
    var ip: String
    var online: Bool
}

extension DeviceDescriptor {
    static func defaultValue() -> DeviceDescriptor {
        return .init(deviceId: "UNKNOWN",
                     name: "UNKNOWN",
                     description: "UNKNOWN",
                     ip: "UNKNOWN",
                     online: false)
    }
}
