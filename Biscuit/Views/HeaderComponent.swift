//
//  HeaderComponent.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

import Combine
import SwiftUI

struct HeaderComponent: View {
    var data: Data
    var event: Event?
    @State private var projectSelection: Int = 0
    @State private var deviceSelection: Int = 0

    var body: some View {
        HStack {
            Picker("Project", selection: $projectSelection) {
                ForEach(Array(data.projectList.enumerated()), id: \.element) { index, element in
                    Text(element).tag(index)
                }
            }
            .onChange(of: projectSelection, perform: { value in
                event?.projectSelectionChanged(value)
            })
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))

            Picker("Device", selection: $deviceSelection) {
                ForEach(Array(data.deviceList.enumerated()), id: \.element) { index, element in
                    Text(element).tag(index)
                }
            }
            .onChange(of: deviceSelection, perform: { value in
                event?.deviceSelectionChanged(value)
            })
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))

            Spacer()
        }
        .background(Colors.Background.panelBackground)
    }
}

extension HeaderComponent {
    struct Data {
        var projectList: [String]
        var deviceList: [String]
    }
    struct Event {
        var projectSelectionChanged: PickerAction
        var deviceSelectionChanged: PickerAction
    }
}

struct HeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        HeaderComponent(data: HeaderComponent.Data(projectList: [],
                                                   deviceList: []))
    }
}
