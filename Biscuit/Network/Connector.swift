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

    func start() {
        NSLog("Starting new connector")
        listener = createListener()

        listener?.stateUpdateHandler = didStateChanged(state:)
        listener?.newConnectionHandler = { [weak self] (connection: NWConnection) in
            guard let self = self else { return }
            let networkConnection = NetworkConnection(with: connection)

            networkConnection.didStopConnection = { (connection: NetworkConnection, error: Error?) in
                NSLog("[Connector][\(connection.id)] Connection closed")
                if let error = error {
                    NSLog("[Connector][\(connection.id)] With error: \(error)")
                }

                self.didStopConnection(connection)
            }

            networkConnection.didStartConnection = { (connection: NetworkConnection) in
                NSLog("[Connector][\(connection.id)] Started")
            }

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
            NSLog("Connected to client at \(port)")
        }
        case .failed(let error):
            listener.cancel()
            NSLog("Failed to connect listener: \(error.localizedDescription)")
        default:
            break
        }
    }

    func didAcceptConnection(_ connection: NetworkConnection) {
        NSLog("[Connector][\(connection.id)] New connection accepted")
        activeConnections.insert(connection)
        connection.start()
    }

    func didStopConnection(_ connection: NetworkConnection) {
        activeConnections.remove(connection)
        NSLog("[Connector][\(connection.id)] Connection closed")
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
}
