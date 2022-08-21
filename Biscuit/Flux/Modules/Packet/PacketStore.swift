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
            case .storePacket(let packet):
                handleStorePacket(packet: packet)
        }
    }
}

private extension PacketStore {
    func handleStorePacket(packet: IncomingPacket) {
        update { state in
            print("[STORE MANIP] Trying to store IncomingPacket: project: \(packet.project.name), device: \(packet.device.name), packet: \(packet.packet.bagelPacketId), url: \(packet.packet.url)")
            let device = Device(descriptor: packet.device, packets: [packet.packet])
            let project = Project(descriptor: packet.project, devices: [device])

            if var foundProject = state.projects.first(where: { project in project.descriptor == packet.project }) {
                print("[STORE MANIP] Found the project")
                if var foundDevice = foundProject.devices.first(where: { device in device.descriptor == packet.device }) {
                    print("[STORE MANIP] Found the device")
                    if foundDevice.packets.contains(packet.packet) {
                        print("[STORE MANIP] Device contains packet, updating")
                        foundDevice.packets.update(with: packet.packet)
                    } else {
                        print("[STORE MANIP] Device not contains packet, inserting")
                        foundDevice.packets.insert(packet.packet)
                    }
                    foundProject.devices.update(with: foundDevice)
                    state.projects.update(with: foundProject)
                } else {
                    print("[STORE MANIP] Device not found, inserting")
                    foundProject.devices.insert(device)
                    state.projects.update(with: foundProject)
                }
            } else {
                print("[STORE MANIP] Project not found, inserting")
                state.projects.insert(project)
            }

            Array(state.projects).describe()
        }
    }
}
