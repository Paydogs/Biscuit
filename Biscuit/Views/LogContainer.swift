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
        HStack {
            Text("Test: \(data.currentValue)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}

extension LogContainer {
    struct Data {
        var currentValue: Int
    }
}
