//
//  HeaderArea.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

import Combine
import SwiftUI
import Factory

struct HeaderArea: View {
    @ObservedObject var domain: HeaderAreaDomain
    var eventHandler: HeaderAreaEventHandling

    var body: some View {
        HStack {
            StandardPicker(data: StandardPicker.Content(title: domain.projectTitle,
                                                        values: domain.projectList),
                           event: StandardPicker.Events(indexSelected: { selected in
                eventHandler.projectSelected(index: selected)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))

            StandardPicker(data: StandardPicker.Content(title: domain.deviceTitle,
                                                        values: domain.deviceList),
                           event: StandardPicker.Events(indexSelected: { selected in
                eventHandler.deviceSelected(index: selected)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))

            Spacer()
        }
        .background(Colors.Background.panelBackground)
    }
}
