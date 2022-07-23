//
//  Connector.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import Foundation
import Network

protocol NetworkConnectionDelegate: AnyObject
{
    func connectionOpened()
    func connectionClosed()
    func connectionError()
    func connectionReceivedData()
}

class Connector {
    var connection: NWConnection?
    var listener: NWListener?
    weak var delegate: NetworkConnectionDelegate?
    private var connectionsByID: [Int: ServerConnection] = [:]

    /*
     self.netService = NetService(domain: BagelConfiguration.netServiceDomain, type: BagelConfiguration.netServiceType, name: BagelConfiguration.netServiceName, port: BagelConfiguration.netServicePort)

     static let netServiceDomain: String = ""
     static let netServiceType: String = "_Bagel._tcp"
     static let netServiceName: String = ""
     static let netServicePort: Int32 = 43435
     */

    func start2() {
        let port: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: 43435)
        let params = NWParameters(tls: nil, tcp: NWProtocolTCP.Options())
        params.includePeerToPeer = true

        listener = try? NWListener(using: params)
        guard let listener = listener else { return }

        listener.service = NWListener.Service(name: "",
                                               type: "_Bagel._tcp")

        listener.newConnectionHandler = self.didAccept(nwConnection:)

        listener.stateUpdateHandler = { [weak self, listener] newState in
            guard let self = self else { return }

            switch newState {
            case .ready:
                    if let port = listener.port {
                    // Listener setup on a port.  Active browsing for this service.
                        NSLog("Fuck something happening")
                }
            case .failed(let error):
                    listener.cancel()
                NSLog("Listener - failed with %{public}@, restarting", error.localizedDescription)
                // Handle restarting listener
            case .setup:
                    NSLog("Setup phase")
            default:
                break
            }
        }

        listener.start(queue: DispatchQueue.global(qos: .background))
    }

    private func didAccept(nwConnection: NWConnection) {
            let connection = ServerConnection(nwConnection: nwConnection)
            self.connectionsByID[connection.id] = connection
            connection.didStopCallback = { _ in
                self.connectionDidStop(connection)
            }
            connection.start()
            connection.send(data: "Welcome you are connection: \(connection.id)".data(using: .utf8)!)
            print("server did open connection \(connection.id)")
    }

    private func connectionDidStop(_ connection: ServerConnection) {
            self.connectionsByID.removeValue(forKey: connection.id)
            print("server did close connection \(connection.id)")
        }

        private func stop() {
            guard let listener = listener else { return }
            listener.stateUpdateHandler = nil
            listener.newConnectionHandler = nil
            listener.cancel()
            for connection in self.connectionsByID.values {
                connection.didStopCallback = nil
                connection.stop()
            }
            self.connectionsByID.removeAll()
        }

    func start() {
        let host: NWEndpoint.Host = .name("_Bagel._tcp", nil)
        let port: NWEndpoint.Port = NWEndpoint.Port(integerLiteral: 43435)
        connection = NWConnection(host: host, port: port, using: .tcp)

        connection?.start(queue: DispatchQueue.global(qos: .background))
    }
}
