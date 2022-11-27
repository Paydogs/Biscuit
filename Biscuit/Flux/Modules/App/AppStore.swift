//
//  AppStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

import Foundation

class AppStore: BaseStore<AppState> {
    override func handleAction(action: FluxAction) {
        guard let action = action as? AppActions else { return }
        print("[AppStore] AppStore is handling action")
        switch action {
            case .didConnectClient(let client):
                handleDidConnectClient(client: client)
            case .didDisconnectClientId(let clientId):
                handleDidDisconnectClient(clientId: clientId)
            case .didReceivedErrors(let error):
                handleDidReceivedErrors(errors: error)
            case .didReceivedInvalidPacket(let packet):
                handleDidReceivedInvalidPacket(packet: packet)
            case .didSelectPackets(let packets):
                handleDidSelectPackets(packets: packets)
            case .didModifiedBuildFilter(let filter):
                handleDidModifiedBuildFilter(filter: filter)
            case .didModifiedPacketFilter(let filter):
                handleDidModifiedPacketFilter(filter: filter)
            case .didResetPacketFilter:
                handleDidResetPacketFilter()
            case .didSendMessage(let message):
                handleDidSendMessage(message: message)
            case .didRemoveLastMessage:
                handleDidRemoveLastMessage()
            case .toggleSidebar:
                handleToggleSidebar()
        }
    }
}

private extension AppStore {
    func handleDidConnectClient(client: Client) {
        update { state in
            print("[APPSTORE MANIP] Client connected: \(client)")
            state.connectedClients.append(client)
        }
    }

    func handleDidDisconnectClient(clientId: String) {
        update { state in
            print("[APPSTORE MANIP] Client disconnected: \(clientId)")
            state.connectedClients.removeAll { client in
                client.id == clientId
            }
        }
    }

    func handleDidReceivedErrors(errors: [AppError]) {
        update { state in
            print("[APPSTORE MANIP] Error: \(errors)")
            state.errors.append(contentsOf: errors)
        }
    }

    func handleDidReceivedInvalidPacket(packet: InvalidPacket) {
        update { state in
            print("[APPSTORE MANIP] Invalid packet: \(packet)")
            state.invalidPackets.append(packet)
        }
    }

    func handleDidSelectPackets(packets: [Packet]) {
        update { state in
            print("[APPSTORE MANIP] packets selected: \(packets.map(\.bagelPacketId))")
            state.selectedPackets = packets
        }
    }

    func handleDidModifiedBuildFilter(filter: BuildFilter) {
        update { state in
            print("[APPSTORE MANIP] build filter changed: \(filter)")
            if let project = filter.project {
                state.buildFilter.project = project
            }

            state.buildFilter.deviceId = filter.deviceId
        }
    }
    func handleDidModifiedPacketFilter(filter: PacketFilter) {
        update { state in
            print("[APPSTORE MANIP] packet filter changed: \(filter)")
            if case .reset = filter.from {
                state.packetFilter.from = .unmodified
            }
            if case let .date(date) = filter.from {
                state.packetFilter.from = .date(date)
            }
            if case .reset = filter.to {
                state.packetFilter.to = .unmodified
            }
            if case let .date(date) = filter.to {
                state.packetFilter.to = .date(date)
            }
            if let statusCode = filter.statusCode {
                state.packetFilter.statusCode = statusCode
            }
            if let url = filter.url {
                state.packetFilter.url = url
            }
        }
    }
    func handleDidResetPacketFilter() {
        update { state in
            print("[APPSTORE MANIP] packet filter reseted")
            state.packetFilter = PacketFilter()
        }
    }
    func handleDidSendMessage(message: String) {
        update { state in
            print("[APPSTORE MANIP] received message")
            state.messages.append(message)
        }
    }
    func handleDidRemoveLastMessage() {
        update { state in
            print("[APPSTORE MANIP] removing message")
            state.messages.removeFirst()
        }
    }
    func handleToggleSidebar() {
        update { state in
            print("[APPSTORE MANIP] removing message")
            state.isSidebarOpen.toggle()
        }
    }
}
