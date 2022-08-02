//
//  Device.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct Device: Equatable {
    var deviceId: String
    var name: String
    var description: String
}

extension Device {
    static func defaultValue() -> Device {
        return .init(deviceId: "",
                     name: "",
                     description: "")
    }
}
