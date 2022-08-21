//
//  Connector.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 24..
//

import Foundation
import Network
import Combine
import Factory

class Connector {
    var listener: NWListener?
    var activeConnections: Set<NetworkConnection> = []

    let bagelPacketParser = BagelPacketParser()
    let packetParser = PacketParser()

    @Injected(BiscuitContainer.postAppErrorUseCase) private var postAppErrorUseCase
    @Injected(BiscuitContainer.storePacketUseCase) private var storePacketUseCase
    @Injected(BiscuitContainer.setActiveConnectionCountUseCase) private var setActiveConnectionCountUseCase

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

private extension Connector {
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
            postAppErrorUseCase.execute(errors: [.cannotConnect])
        default:
            break
        }
    }

    func didAcceptConnection(_ connection: NetworkConnection) {
        print("[Connector] New connection accepted from \(connection.connection.endpoint)")
        activeConnections.insert(connection)
        setActiveConnectionCountUseCase.execute(count: activeConnections.count)
        print("[Connector] Number of active connections: \(activeConnections.count)")
        connection.start()
    }

    func didStopConnection(_ connection: NetworkConnection) {
        activeConnections.remove(connection)
        setActiveConnectionCountUseCase.execute(count: activeConnections.count)
        print("[Connector] Connection closed from \(connection.connection.endpoint)")
        print("[Connector] Number of active connections: \(activeConnections.count)")
    }
}

private extension Connector {
    func createListener() -> NWListener? {
        let port: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: BagelConfig.defaultPort)

        let tcpOptions = NWProtocolTCP.Options()
        let params = NWParameters(tls: nil, tcp: tcpOptions)

        let listener = try? NWListener(using: params, on: port)
        let service = NWListener.Service(name: BagelConfig.defaultServiceName,
                                         type: BagelConfig.defaultServiceType)
        listener?.service = service
        return listener
    }

    func handleConnectionResponses(connection: NetworkConnection) {
        connection.didStartConnection = { (connection: NetworkConnection) in
            print("[Connector] Started")
        }

        connection.didReceivedData = { [weak self] (connection: NetworkConnection, data: Data) in
            DispatchQueue.global(qos: .background).async {
                guard let self = self,
                      let bagelPacket = self.bagelPacketParser.parseData(data) else {
                    print("[Connector] WRONG DATA")
                    return
                }

                let packet = self.packetParser.parsePacket(bagelPacket, client: connection.connection.endpoint.debugDescription)
                print("[Connector] Got packet: \(packet.device.ip): \(packet.packet.url)")
                self.storePacketUseCase.execute(packet: packet)
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
