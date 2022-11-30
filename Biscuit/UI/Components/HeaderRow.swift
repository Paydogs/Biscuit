//
//  HeaderRow.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import Foundation
import SwiftUI

struct HeaderRow: Identifiable {
    var id: String {
        return key
    }
    let key: String
    let value: String
}
