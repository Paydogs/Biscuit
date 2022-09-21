//
//  StandardPicker.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI

struct StandardPicker: View {
    @State private var selectedIndex: Int?

    var data: Content
    var event: Events?

    var body: some View {
        Picker(data.title, selection: $selectedIndex) {
            if data.values.isEmpty {
                Text("None").tag(nil as Int?)
            } else {
                ForEach(Array(data.values.enumerated()), id: \.element) { index, element in
                    Text(element.text).tag(index as Int?)
                }
            }
        }
        .onChange(of: data.values, perform: { newValue in
            if !newValue.isEmpty {
                selectedIndex = 0
            }
        })
        .onChange(of: selectedIndex, perform: { selection in
            guard let selection = selection else {
                return
            }
            event?.itemSelected(data.values[selection])
        })
    }
}

extension StandardPicker {
    struct PickerItem: Equatable, Hashable {
        var id: String
        var text: String
    }
    struct Content {
        var title: String
        var values: [PickerItem]
    }
    struct Events {
        var itemSelected: (PickerItem)->()
    }
}
