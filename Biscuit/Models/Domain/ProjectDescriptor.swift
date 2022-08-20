//
//  Project.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Foundation

struct ProjectDescriptor: Hashable {
    let id: String
    let name: String
}

extension ProjectDescriptor {
    static func defaultValue() -> ProjectDescriptor {
        return .init(id: "UNKNOWN",
                     name: "UNKNOWN")
    }
}
