//
//  StandardPicker.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI

struct StandardPicker: View {
    @State private var selectedId: String?

    typealias PickerAction = (PickerItem)->()
    var data: Content
    var event: Events?

    init(selectedId: String? = nil, data: Content, event: Events? = nil) {
        self.selectedId = selectedId
        self.data = data
        self.event = event

        if let selectedId = data.selectedId {
            _selectedId = State(initialValue: selectedId)
        }
    }

    var body: some View {
        Picker(data.title, selection: $selectedId) {
            if data.values.isEmpty {
                Text(Localized.StandardPicker.noneSelected).tag(nil as String?)
            } else {
                ForEach(Array(data.values.enumerated()), id: \.element.id) { index, element in
                    Label(element.text, systemImage: element.icon ?? "")
                        .labelStyle(.titleAndIcon)
                        .tag(element.id as String?)
                }
            }
        }
        .onChange(of: data.values, perform: { newValue in
            if !newValue.isEmpty {
                selectedId = newValue.first?.id
            } else {
                selectedId = nil
            }
        })
        .onChange(of: selectedId, perform: { selection in
            guard let selection = selection else {
                return
            }
            guard let selectItem = data.values.first(where: { item in
                item.id == selection
            }) else { return }
            event?.itemSelected(selectItem)
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
