//
//  StandardPicker.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI

struct StandardPicker: View {
    @State private var selectedIndex: Int?

    var data: Data
    var event: Event?

    var body: some View {
        Picker(data.title, selection: $selectedIndex) {
            if data.values.isEmpty {
                Text("None").tag(nil as Int?)
            } else {
                ForEach(Array(data.values.enumerated()), id: \.element) { index, element in
                    Text(element).tag(index as Int?)
                }
            }
        }
        .onChange(of: data.values, perform: { newValue in
            if !newValue.isEmpty {
                selectedIndex = 0
            }
        })
        .onChange(of: selectedIndex, perform: { projectSelection in
            guard let projectSelection = projectSelection else {
                return
            }

            event?.indexSelected(projectSelection)
        })
    }
}

extension StandardPicker {
    struct Data {
        var title: String
        var values: [String]
    }
    struct Event {
        var indexSelected: (Int)->()
    }
}
