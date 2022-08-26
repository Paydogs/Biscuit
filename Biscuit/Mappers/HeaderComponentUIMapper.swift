//
//  HeaderComponentUIMapper.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

struct HeaderComponentUIMapper {
    static func getProjectNameList(list: Set<Project>?) -> [String] {
        guard let list = list else { return [] }
        return list.map { (project: Project) -> String in
            return project.descriptor.name
        }
    }

    static func getDeviceNameList(list: Set<Device>?) -> [String] {
        guard let list = list else { return [] }
        return list.map { (device: Device) -> String in
            return device.descriptor.name
        }
    }
}
