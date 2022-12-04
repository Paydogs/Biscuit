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
                handleDidStorePacket(incomingPacket: packet)
            case .didReceivedInvalidPacket(let packet):
                handleDidReceivedInvalidPacket(packet: packet)
            case .didClientWentOffline(let client):
                handleDidClientWentOffline(client: client)
            case .didTogglePacketPinStatus(let packetIds):
                handleDidTogglePacketPinStatus(packetIds: packetIds)
            case .didSetPacketPinStatusOn(let packetIds):
                handleDidSetPacketPinStatusOn(packetIds: packetIds)
            case .didSetPacketPinStatusOff(let packetIds):
                handleDidSetPacketPinStatusOff(packetIds: packetIds)
            case .deleteOfflineDevices:
                handleDeleteOfflineDevices()
        }
    }
}

private extension PacketStore {
    func handleDidStorePacket(incomingPacket: IncomingPacket) {
        update { state in
            print("""
                [PACKETSTORE MANIP] Trying to store IncomingPacket: project: \(incomingPacket.projectDescriptor.name),\
                device: \(incomingPacket.deviceDescriptor.name), packet: \(incomingPacket.packet.bagelPacketId), url: \(incomingPacket.packet.url)
                """)
            let device = Device(descriptor: incomingPacket.deviceDescriptor, packets: [incomingPacket.packet], online: true)
            let project = Project(descriptor: incomingPacket.projectDescriptor, devices: [device])
            var packet = incomingPacket.packet

            if var existingProject = state.projects.first(where: { project in project.descriptor == incomingPacket.projectDescriptor }) {
                if var existingDevice = existingProject.devices.first(where: { device in device.descriptor == incomingPacket.deviceDescriptor }) {
                    print("[PACKETSTORE MANIP] Device found, updating packet")
                    if let existingPacket = existingDevice.packets.first(where: { foundPacket in foundPacket.id == incomingPacket.packet.id }) {
                        packet.received = existingPacket.received
                        existingDevice.packets.update(with: packet)
                    } else {
                        existingDevice.packets.update(with: packet)
                    }
                    existingProject.devices.update(with: existingDevice)
                } else {
                    print("[PACKETSTORE MANIP] Device not found, inserting device and packet")
                    existingProject.devices.update(with: device)
                }
                state.projects.update(with: existingProject)
            } else {
                print("[PACKETSTORE MANIP] Project not found, inserting project, device and packet")
                state.projects.update(with: project)
            }

            Array(state.projects).describe() // printing description
        }
    }

    func handleDidReceivedInvalidPacket(packet: InvalidPacket) {
        update { state in
            print("[PACKETSTORE MANIP] Invalid packet: \(packet)")
            state.invalidPackets.append(packet)
        }
    }

    func handleDidClientWentOffline(client: Client) {
        print("[PACKETSTORE MANIP] Trying to turn \(client.id) offline")
        updateDevice(deviceId: client.id) { device in
            device.online = false
        }
    }

    func handleDeleteOfflineDevices() {
        print("[PACKETSTORE MANIP] Trying to delete offline devices")
        update { state in
            for var project in state.projects {
                for device in project.devices {
                    if !device.online {
                        project.devices.remove(device)
                        state.projects.update(with: project)
                    }
                }
            }

            Array(state.projects).describe()
        }
    }

    func handleDidTogglePacketPinStatus(packetIds: [String]) {
        print("[PACKETSTORE MANIP] Trying to toggle \(packetIds) pin status")
        updatePackets(packetIds: packetIds) { packet in
            packet.pinned.toggle()
        }
    }

    func handleDidSetPacketPinStatusOn(packetIds: [String]) {
        print("[PACKETSTORE MANIP] Trying to turn the pin status on \(packetIds) to ON")
        updatePackets(packetIds: packetIds) { packet in
            packet.pinned = true
        }
    }

    func handleDidSetPacketPinStatusOff(packetIds: [String]) {
        print("[PACKETSTORE MANIP] Trying to turn the pin status on \(packetIds) to OFF")
        updatePackets(packetIds: packetIds) { packet in
            packet.pinned = false
        }
    }
}

private extension PacketStore {
    typealias TransformPacket = (inout Packet) -> Void
    typealias TransformDevice = (inout Device) -> Void

    func updatePackets(packetIds: [String], with transform: TransformPacket) {
        update { state in
            for var project in state.projects {
                for var device in project.devices {
                    for var packet in device.packets {
                        if packetIds.contains(packet.id) {
                            transform(&packet)
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

    func updateDevice(deviceId: String, with transform: TransformDevice) {
        update { state in
            for var project in state.projects {
                for var device in project.devices {
                    if device.id.contains(deviceId) {
                        transform(&device)
                        project.devices.update(with: device)
                        state.projects.update(with: project)
                    }
                }
            }

            Array(state.projects).describe()
        }
    }
}
