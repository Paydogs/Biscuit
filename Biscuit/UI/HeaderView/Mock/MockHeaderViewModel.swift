//
//  MockHeaderViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

class MockHeaderViewModel: HeaderViewModelInterface {
    var projectList: [StandardPicker.PickerItem] {
        [.init(id: "Project_1", text: "Project 1"),
         .init(id: "Project_2", text: "Project 2")]
    }
    var deviceList: [StandardPicker.PickerItem] {
        [.init(id: "Device_1", text: "Device 1"),
         .init(id: "Device_2", text: "Device 2")]
    }

    func projectSelected(identifier: String) { }
    func deviceSelected(identifier: String) { }
    func toggleSidebar() { }
}
