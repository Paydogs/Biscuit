//
//  HeaderComponent.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

import Combine
import SwiftUI
import Factory

struct HeaderComponent: View {
    @Injected(BiscuitContainer.headerController) var controller

    var body: some View {
        HStack {
            StandardPicker(data: StandardPicker.Data(title: "Project",
                                                     values: controller.projectList),
                           event: StandardPicker.Event(indexSelected: { selected in
                controller.projectSelected(index: selected)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))

            StandardPicker(data: StandardPicker.Data(title: "Device",
                                                     values: controller.deviceList),
                           event: StandardPicker.Event(indexSelected: { selected in
                controller.deviceSelected(index: selected)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))

            Spacer()
        }
        .background(Colors.Background.panelBackground)
    }
}

