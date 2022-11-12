//
//  CommonPicker.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 12..
//

import SwiftUI
import AppKit

struct CommonPicker: View {
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
        Picker(data.title ?? "", selection: $selectedIndex) {
            ForEach(Array(data.values.enumerated()), id: \.element) { index, element in
                Text(element.text)
                    .tag(element.id)
                    .font(Fonts.defaultFont(sized: 24).swiftUIFont)
            }
        }
        .font(Fonts.defaultFont(sized: 24).swiftUIFont)
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

extension CommonPicker {
    struct PickerItem: Identifiable, Hashable {
        var id: String
        var text: String


    }
    struct Content {
        var title: String?
        var values: [PickerItem]
        var selectedId: String?
    }
    struct Events {
        var itemSelected: PickerAction
    }
}

struct CommonPicker_Previews: PreviewProvider {
    static var previews: some View {
        CommonPicker(data: CommonPicker.Content(values: [CommonPicker.PickerItem(id: "Item1", text: "Item 1"),
                                                                     CommonPicker.PickerItem(id: "Item2", text: "Item 2"),
                                                                     CommonPicker.PickerItem(id: "Item3", text: "Item 3")],
                                                                        selectedId: "Item2"))
        .darkPreview(title: "Dark Filled")
        CommonPicker(data: CommonPicker.Content(values: [CommonPicker.PickerItem(id: "Item1", text: "Item 1"),
                                                                     CommonPicker.PickerItem(id: "Item2", text: "Item 2"),
                                                                     CommonPicker.PickerItem(id: "Item3", text: "Item 3")],
                                                                        selectedId: "Item2"))
        .lightPreview(title: "Light Filled")

    }
}

