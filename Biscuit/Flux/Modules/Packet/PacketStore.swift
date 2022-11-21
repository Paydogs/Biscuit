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
            case .didTogglePacketPinStatus(let packetIds):
                handleDidTogglePacketPinStatus(packetIds: packetIds)
        }
    }
}

private extension PacketStore {
    func handleDidStorePacket(packet: IncomingPacket) {
        update { state in
            print("""
                [PACKETSTORE MANIP] Trying to store IncomingPacket: project: \(packet.projectDescriptor.name),\
                device: \(packet.deviceDescriptor.name), packet: \(packet.packet.bagelPacketId), url: \(packet.packet.url)
                """)
            let device = Device(descriptor: packet.deviceDescriptor, packets: [packet.packet], online: true)
            let project = Project(descriptor: packet.projectDescriptor, devices: [device])

            if var foundProject = state.projects.first(where: { project in project.descriptor == packet.projectDescriptor }) {
                if var foundDevice = foundProject.devices.first(where: { device in device.descriptor == packet.deviceDescriptor }) {
                    print("[PACKETSTORE MANIP] Device found, updating packet")
                    foundDevice.packets.update(with: packet.packet)
                    foundProject.devices.update(with: foundDevice)
                } else {
                    print("[PACKETSTORE MANIP] Device not found, inserting device and packet")
                    foundProject.devices.update(with: device)
                }
                state.projects.update(with: foundProject)
            } else {
                print("[PACKETSTORE MANIP] Project not found, inserting project, device and packet")
                state.projects.update(with: project)
            }

            Array(state.projects).describe() // printing description
        }
    }

    func handleDidClientWentOffline(client: Client) {
        update { state in
            print("[PACKETSTORE MANIP] Trying to turn \(client.id) offline")
            for var project in state.projects {
                for var device in project.devices {
                    if device.id.contains(client.id) {
                        device.online = false
                        project.devices.update(with: device)
                        state.projects.update(with: project)
                    }
                }
            }

            Array(state.projects).describe()
        }
    }

    func handleDidTogglePacketPinStatus(packetIds: [String]) {
        update { state in
            print("[PACKETSTORE MANIP] Trying to toggle \(packetIds) pin status")
            for var project in state.projects {
                for var device in project.devices {
                    for var packet in device.packets {
                        if packetIds.contains(packet.id) {
                            packet.pinned.toggle()
                            device.packets.update(with: packet)
                            project.devices.update(with: device)
                            state.projects.update(with: project)
                        }
                    }
                }
            }

            Array(state.projects).describe()
        }
    }
}
