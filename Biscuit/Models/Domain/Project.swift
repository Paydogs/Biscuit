//
//  Project.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

struct Project: Identifiable {
    var descriptor: ProjectDescriptor
    var devices: Set<Device>
    var id: String {
        descriptor.id
    }
}
