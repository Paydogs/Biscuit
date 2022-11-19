//
//  PacketStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

class PacketStore: BaseStore<PacketState> {
    override func handleAction(action: FluxAction) {
        guard let action = action as? PacketActions else { return }
        print("[PacketStore] PacketStore is handling action")
        switch action {
            case .didStorePacket(let packet):
                handleDidStorePacket(packet: packet)
            case .didClientWentOffline(let client):
                handleDidClientWentOffline(client: client)
        }
    }
}

private extension PacketStore {
    func handleDidStorePacket(packet: IncomingPacket) {
        update { state in
            print("[PACKETSTORE MANIP] Trying to store IncomingPacket: project: \(packet.project.name), device: \(packet.device.name), packet: \(packet.packet.bagelPacketId), url: \(packet.packet.url)")
            let device = Device(descriptor: packet.device, packets: [packet.packet])
            let project = Project(descriptor: packet.project, devices: [device])

            if var foundProject = state.projects.first(where: { project in project.descriptor == packet.project }) {
                print("[PACKETSTORE MANIP] Found the project")
                if var foundDevice = foundProject.devices.first(where: { device in device.descriptor == packet.device }) {
                    print("[PACKETSTORE MANIP] Found the device")
                    if foundDevice.packets.contains(packet.packet) {
                        print("[PACKETSTORE MANIP] Device contains packet, updating")
                        foundDevice.packets.update(with: packet.packet)
                    } else {
                        print("[PACKETSTORE MANIP] Device not contains packet, inserting")
                        foundDevice.packets.insert(packet.packet)
                    }
                    foundProject.devices.update(with: foundDevice)
                    state.projects.update(with: foundProject)
                } else {
                    print("[PACKETSTORE MANIP] Device not found, inserting")
                    foundProject.devices.insert(device)
                    state.projects.update(with: foundProject)
                }
            } else {
                print("[PACKETSTORE MANIP] Project not found, inserting")
                state.projects.insert(project)
            }

            Array(state.projects).describe() // printing description
        }
    }

    func handleDidClientWentOffline(client: Client) {
        update { state in
            print("[PACKETSTORE MANIP] Trying to turn \(client.id) offline")
            for var project in state.projects {
                for device in project.devices {
                    print("[PACKETSTORE MANIP] checking device: \(device.descriptor)")
                    if device.id.contains(client.id) {
                        var updatedDevice = device
                        print("[PACKETSTORE MANIP] found the device: \(device.descriptor)")
                        updatedDevice.descriptor.online = false
                        print("[PACKETSTORE MANIP] updating the device: \(updatedDevice.descriptor)")
                        project.devices.remove(device)
                        project.devices.insert(updatedDevice)
                        print("[PACKETSTORE MANIP] updating project: \(project.descriptor)")
                    }
                    state.projects.update(with: project)
                }
            }
            Array(state.projects).describe()
        }
    }
}
