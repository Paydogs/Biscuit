//
//  HeaderViewDomain.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import Combine

class HeaderViewDomain: ObservableObject {
    @Published var projectTitle: String = "Project"
    @Published var projectList: [StandardPicker.PickerItem] = []
    @Published var deviceTitle: String = "Device"
    @Published var deviceList: [StandardPicker.PickerItem] = []
}
