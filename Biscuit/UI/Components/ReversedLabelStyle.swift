//
//  ReversedLabelStyle.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import SwiftUI

struct ReversedStretchedLabelStyle: LabelStyle {

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
                .frame(maxWidth: .infinity, alignment: .leading)
            configuration.icon
        }
        .contentShape(Rectangle())
    }
}
