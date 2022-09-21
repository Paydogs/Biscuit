//
//  Filter.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import Foundation

struct Filter: Equatable {
    var project: String?
    var deviceId: String?
    var from: Date?
    var to: Date?
}
