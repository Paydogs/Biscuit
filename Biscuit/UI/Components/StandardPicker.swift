//
//  StandardPicker.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI

struct StandardPicker: View {
    @State private var selectedIndex: Int?

    typealias PickerAction = (PickerItem)->()
    var data: Content
    var event: Events?

    init(selectedIndex: Int? = nil, data: Content, event: Events? = nil) {
        self.selectedIndex = selectedIndex
        self.data = data
        self.event = event

        if let selectedId = data.selectedId {
            _selectedIndex = State(initialValue: data.values.firstIndex(where: { (item: PickerItem) in
                item.id == selectedId
            }))
        }
    }

    var body: some View {
        Picker(data.title, selection: $selectedIndex) {
            if data.values.isEmpty {
                Text(Localized.StandardPicker.noneSelected).tag(nil as Int?)
            } else {
                ForEach(Array(data.values.enumerated()), id: \.element.id) { index, element in
                    HStack {
                        if let icon = element.icon {
                            Image(systemName: icon)
                        }
                        Text(element.text)
                    }.tag(index as Int?)
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
    // Single picker item
    struct PickerItem: Equatable, Hashable {
        var id: String
        var text: String
        var icon: String? = nil
    }
    // The whole component
    struct Content {
        var title: String
        var values: [PickerItem]
        var selectedId: String?
    }
    struct Events {
        var itemSelected: PickerAction
    }
}

struct StandardPicker_Previews: PreviewProvider {
    static var previews: some View {
        StandardPicker(data: StandardPicker.Content(title: "Standard picker 1:",
                                                    values: []))
        .darkPreview(title: "Dark Empty")
        StandardPicker(data: StandardPicker.Content(title: "Standard picker 1:",
                                                    values: []))
        .lightPreview(title: "Light Empty")

        StandardPicker(data: StandardPicker.Content(title: "Standard picker 2:",
                                                    values: [StandardPicker.PickerItem(id: "Item1", text: "Item 1"),
                                                             StandardPicker.PickerItem(id: "Item2", text: "Item 2")],
                                                    selectedId: "Item2"))
        .darkPreview(title: "Dark Filled")
        StandardPicker(data: StandardPicker.Content(title: "Standard picker 2:",
                                                    values: [StandardPicker.PickerItem(id: "Item1", text: "Item 1"),
                                                             StandardPicker.PickerItem(id: "Item2", text: "Item 2")],
                                                    selectedId: "Item2"))
        .lightPreview(title: "Light Filled")
        StandardPicker(data: StandardPicker.Content(title: "Standard picker 2:",
                                                    values: [StandardPicker.PickerItem(id: "Item1", text: "Item 1", icon: IconName.iPhoneOn),
                                                             StandardPicker.PickerItem(id: "Item2", text: "Item 2", icon: IconName.iPhoneOff)],
                                                    selectedId: "Item2"))
        .darkPreview(title: "Dark Filled and icon")
        StandardPicker(data: StandardPicker.Content(title: "Standard picker 2:",
                                                    values: [StandardPicker.PickerItem(id: "Item1", text: "Item 1", icon: IconName.iPhoneOn),
                                                             StandardPicker.PickerItem(id: "Item2", text: "Item 2", icon: IconName.iPhoneOff)],
                                                    selectedId: "Item2"))
        .lightPreview(title: "Light Filled and icon")


    }
}
