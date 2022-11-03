//
//  HeaderView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

import Combine
import SwiftUI
import Factory

struct HeaderView: View {
    @StateObject private var domain: HeaderViewDomain
    private var eventHandler: HeaderViewEventHandling

    init(controller: HeaderViewController) {
        _domain = StateObject(wrappedValue: controller.domain)
        eventHandler = controller
    }

    var body: some View {
        HStack {
            StandardPicker(data: StandardPicker.Content(title: domain.projectTitle,
                                                        values: domain.projectList),
                           event: StandardPicker.Events(itemSelected: { selected in
                eventHandler.projectSelected(identifier: selected.id)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                
            StandardPicker(data: StandardPicker.Content(title: domain.deviceTitle,
                                                        values: domain.deviceList),
                           event: StandardPicker.Events(itemSelected: { selected in
                eventHandler.deviceSelected(identifier: selected.id)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
                
            Spacer()
        }
        .background(Colors.Background.panelBackground.opacity(0.2))
    }
}
