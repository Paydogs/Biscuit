//
//  PacketTableRow.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 28..
//

import Foundation
import SwiftUI

struct PacketTableRow: Identifiable {
    let id: String
    let status: String
    let statusColor: Color
    var method: String
    let methodColor: Color
    var url: String
    var date: String
}
