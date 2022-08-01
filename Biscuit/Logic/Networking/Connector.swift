//
//  Connector.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 24..
//

import Foundation
import Network

class Connector {
    var listener: NWListener?
    var activeConnections: Set<NetworkConnection> = []
    let bagelPacketParser = BagelPacketParser()
    let messageParser = MessageParser()

    func start() {
        print("Starting new connector")
        listener = createListener()

        listener?.stateUpdateHandler = didStateChanged(state:)
        listener?.newConnectionHandler = { [weak self] (connection: NWConnection) in
            guard let self = self else { return }
            let networkConnection = NetworkConnection(with: connection)
            self.handleConnectionResponses(connection: networkConnection)
            self.didAcceptConnection(networkConnection)
        }

        listener?.start(queue: DispatchQueue.global(qos: .default))
//        listener?.start(queue: DispatchQueue(label: "Connector"))
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
        default:
            break
        }
    }

    func didAcceptConnection(_ connection: NetworkConnection) {
        print("[Connector] New connection accepted")
        activeConnections.insert(connection)
        print("[Connector] Number of active connections: \(activeConnections.count)")
        connection.start()
    }

    func didStopConnection(_ connection: NetworkConnection) {
        activeConnections.remove(connection)
        print("[Connector] Connection closed")
        print("[Connector] Number of active connections: \(activeConnections.count)")
    }
}

private extension Connector {
    func createListener() -> NWListener? {
        let port: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: BagelConfig.defaultPort)

        let tcpOptions = NWProtocolTCP.Options()
        tcpOptions.persistTimeout = 30
        tcpOptions.connectionDropTime = 30
        tcpOptions.connectionTimeout = 30
//        tcpOptions.noDelay = true

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
            print("RECEIVED \(data.count) bytes")
            DispatchQueue.global(qos: .background).async {
                guard let self = self,
                      let packet = self.bagelPacketParser.parseData(data) else {
                    print("WRONG DATA")
                    return
                }
                if let url = packet.requestInfo?.url {
                    print("Parsed a \(url) packet")
                }

                let message = self.messageParser.parseMessage(from: packet)
                print("[Connector] converted to message:")
                self.describeMessage(message: message)
            }
        }

        connection.didStopConnection = { (connection: NetworkConnection, error: Error?) in
            print("[Connector] Connection closed")
            if let error = error {
                print("[Connector] With error: \(error)")
            }

            self.didStopConnection(connection)
        }
    }
}

private extension Connector {
    func describeMessage(message: Message) {
        DispatchQueue.global(qos: .background).async {
        print("\n====================")
        print("[Connector] url: \(message.url)")
        print("[Connector] statusCode: \(message.statusCode)")
        print("[Connector] device: \(message.device)")
        print("[Connector] request: \(message.request)")
        print("[Connector] response: \(message.response)")
        print("====================\n")
        }
    }
}
