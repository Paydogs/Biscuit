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
        NSLog("Starting new connector")
        listener = createListener()

        listener?.stateUpdateHandler = didStateChanged(state:)
        listener?.newConnectionHandler = { [weak self] (connection: NWConnection) in
            guard let self = self else { return }
            let networkConnection = NetworkConnection(with: connection)
            self.handleConnectionResponses(connection: networkConnection)
            self.didAcceptConnection(networkConnection)
        }

        listener?.start(queue: DispatchQueue.global(qos: .background))
    }
}

private extension Connector {
    func didStateChanged(state: NWListener.State) {
        guard let listener = listener else { return }

        switch state {
        case .ready:
            if let port = listener.port {
            NSLog("[Connector] Connected to client at \(port)")
        }
        case .failed(let error):
            listener.cancel()
            NSLog("[Connector] Failed to connect listener: \(error.localizedDescription)")
        default:
            break
        }
    }

    func didAcceptConnection(_ connection: NetworkConnection) {
        NSLog("[Connector][\(connection.id)] New connection accepted")
        activeConnections.insert(connection)
        NSLog("[Connector] Number of active connections: \(activeConnections.count)")
        connection.start()
    }

    func didStopConnection(_ connection: NetworkConnection) {
        activeConnections.remove(connection)
        NSLog("[Connector][\(connection.id)] Connection closed")
        NSLog("[Connector] Number of active connections: \(activeConnections.count)")
    }
}

private extension Connector {
    func createListener() -> NWListener? {
        let port: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: BagelConfig.defaultPort)
        let params = NWParameters(tls: nil, tcp: NWProtocolTCP.Options())
        params.includePeerToPeer = true

        let listener = try? NWListener(using: params, on: port)
        listener?.service = NWListener.Service(name: BagelConfig.defaultServiceName,
                                               type: BagelConfig.defaultServiceType)
        return listener
    }

    func handleConnectionResponses(connection: NetworkConnection) {
        connection.didStartConnection = { (connection: NetworkConnection) in
            NSLog("[Connector][\(connection.id)] Started")
        }

        connection.didReceivedData = { [weak self] (connection: NetworkConnection, data: Data) in
            guard let self = self,
                  let packet = self.bagelPacketParser.parseData(data) else {
                NSLog("WRONG DATA")
                return
            }

            let message = self.messageParser.parseMessage(from: packet)
            print("[Connector][\(connection.id)] converted to message:")
            self.describeMessage(message: message)
        }

        connection.didStopConnection = { (connection: NetworkConnection, error: Error?) in
            NSLog("[Connector][\(connection.id)] Connection closed")
            if let error = error {
                NSLog("[Connector][\(connection.id)] With error: \(error)")
            }

            self.didStopConnection(connection)
        }
    }
}

private extension Connector {
    func describeMessage(message: Message) {
        print("\n\n====================")
        print("[Connector][\(message.bagelPacketId)] url: \(message.url)")
        print("[Connector][\(message.bagelPacketId)] statusCode: \(message.statusCode)")
        print("[Connector][\(message.bagelPacketId)] device: \(message.device)")
        print("[Connector][\(message.bagelPacketId)] request: \(message.request)")
        print("[Connector][\(message.bagelPacketId)] response: \(message.response)")
        print("====================\n\n")
    }
}
