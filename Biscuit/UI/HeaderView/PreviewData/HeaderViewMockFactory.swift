//
//  HeaderViewMockFactory.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Foundation

struct HeaderViewMockFactory {
    static func createDummyDomain() -> HeaderViewDomain {
        let domain = HeaderViewDomain()
        domain.projectList = [.init(id: "Project_1", text: "Project 1"),
                              .init(id: "Project_2", text: "Project 2")]
        domain.deviceList = [.init(id: "Device_1", text: "Device 1"),
                             .init(id: "Device_2", text: "Device 2")]
        return domain
    }

    static func createDummyHandler() -> HeaderViewEventHandling {
        return DummyHandler()
    }
}

private extension HeaderViewMockFactory {
    struct DummyHandler: HeaderViewEventHandling {
        func projectSelected(identifier: String) { }
        func deviceSelected(identifier: String) { }
    }
}