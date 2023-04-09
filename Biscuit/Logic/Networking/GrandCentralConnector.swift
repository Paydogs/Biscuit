//
//  GrandCentralConnector.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 24..
//

import Foundation
import Network
import Combine
import Factory

class GrandCentralConnector {
    var listener: NWListener?
    var activeConnections: Set<NetworkConnection> = []

    let bagelPacketParser = BagelPacketParser()
    let packetParser = PacketParser()

    @Injected(BiscuitContainer.dispatcher) private var dispatcher

    func start() {
        print("[Connector] Starting new connector")
        listener = createListener()

        listener?.stateUpdateHandler = didStateChanged(state:)
        listener?.newConnectionHandler = { [weak self] (connection: NWConnection) in
            guard let self = self else { return }
            let networkConnection = NetworkConnection(with: connection)
            self.handleConnectionResponses(connection: networkConnection)
            self.didAcceptConnection(networkConnection)
        }

        listener?.start(queue: DispatchQueue.global(qos: .default))
    }
}

private extension GrandCentralConnector {
    func didStateChanged(state: NWListener.State) {
        guard let listener = listener else { return }

        switch state {
        case .ready:
            if let port = listener.port {
            print("[Connector] Connected to client at \(port)")
        }
        case .failed(let error):
            listener.cancel()
            print("[Connector] Failed to connect listener: \(error.localizedDescription)")
            let action = AppActions.didReceivedErrors([.cannotConnect])
            dispatcher.dispatch(action: action)
        default:
            break
        }
    }

    func didAcceptConnection(_ connection: NetworkConnection) {
        print("[Connector] New connection accepted from \(connection.connection.endpoint)")
        activeConnections.insert(connection)
        let action = AppActions.didConnectClient(connection.client)
        dispatcher.dispatch(action: action)
        print("[Connector] Number of active connections: \(activeConnections.count)")
        connection.start()
    }

    func didStopConnection(_ connection: NetworkConnection) {
        activeConnections.remove(connection)
        let action = AppActions.didDisconnectClientId(connection.client.id)
        dispatcher.dispatch(action: action)
        let packetAction = PacketActions.didClientWentOffline(connection.client)
        dispatcher.dispatch(action: packetAction)
        print("[Connector] Connection closed from \(connection.connection.endpoint)")
        print("[Connector] Number of active connections: \(activeConnections.count)")
    }
}

private extension GrandCentralConnector {
    func createListener() -> NWListener? {
        let port: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: BagelConfig.defaultPort)

        let params = NWParameters(tls: nil)

        let listener = try? NWListener(using: params, on: port)
        let service = NWListener.Service(name: BagelConfig.defaultServiceName,
                                         type: BagelConfig.defaultServiceType,
                                         domain: BagelConfig.defaultServiceDomain)
        listener?.service = service
        return listener
    }

    func handleConnectionResponses(connection: NetworkConnection) {
        connection.didStartConnection = { (connection: NetworkConnection) in
            print("[Connector] Started")
        }

        connection.didReceivedData = { [weak self] (connection: NetworkConnection, data: Data) in
            DispatchQueue.global(qos: .background).async {
                guard let self = self else { return }
                let receivedDate = Double(Date().timeIntervalSince1970)
                guard let bagelPacket = self.bagelPacketParser.parseData(data) else {
                    print("[Connector] WRONG DATA... INVALID, UNKNOWN")
                    let action = PacketActions.didReceivedInvalidPacket(InvalidPacket(body: data))
                    self.dispatcher.dispatch(action: action)
                    return
                }

                let packet = self.packetParser.parsePacket(bagelPacket, client: connection.client, received: receivedDate)
                print("[Connector] Got packet: \(packet.deviceDescriptor.ip): \(packet.packet.url)")
                let action = PacketActions.didStorePacket(packet)
                self.dispatcher.dispatch(action: action)
            }
        }

        connection.didStopConnection = { (connection: NetworkConnection, error: Error?) in
            if let error = error {
                print("[Connector] Connection closed with error: \(error)")
            }

            self.didStopConnection(connection)
        }
    }
}
