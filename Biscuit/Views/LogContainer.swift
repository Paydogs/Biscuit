//
//  LogContainer.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import Combine
import SwiftUI

struct LogContainer: View {
    var data: Data

    var body: some View {
        Table(data.packets) {
            TableColumn("Status", value: \.status)
                .width(max: 50)
            TableColumn("Method", value: \.method)
                .width(max: 50)
            TableColumn("Url", value: \.url)
            TableColumn("Date", value: \.date)
        }
    }
}

extension LogContainer {
    struct Data {
        var packets: [PacketTableRow]
    }
}
