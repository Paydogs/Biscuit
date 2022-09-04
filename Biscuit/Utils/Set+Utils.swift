//
//  Set+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import Foundation

extension Set where Element == Project {
    func sorted() -> [Project] {
        return self.sorted { (lhs:Project, rhs: Project) in
            lhs.descriptor.name < rhs.descriptor.name
        }
    }
}

extension Set where Element == Device {
    func sorted() -> [Device] {
        return self.sorted { (lhs:Device, rhs: Device) in
            lhs.descriptor.name < rhs.descriptor.name
        }
    }
}
