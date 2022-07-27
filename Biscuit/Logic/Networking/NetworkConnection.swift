//
//  NetworkConnection.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 24..
//

import Foundation
import Network

class NetworkConnection {
    let MTU = 65536
    let connection: NWConnection
    let id: String

    var didStartConnection: ((NetworkConnection) -> Void)? = nil
    var didReceivedData: ((NetworkConnection, Data) -> Void)? = nil
    var didStopConnection: ((NetworkConnection, Error?) -> Void)? = nil

    init(with connection: NWConnection) {
        self.connection = connection
        self.id = UUID().uuidString
    }
    
    func start() {
        print("[NetworkConnection] Connection starting...")
        connection.stateUpdateHandler = { [weak self] (state: NWConnection.State) in
            self?.stateDidChange(to: state)
        }

//        connection.start(queue: .global(qos: .default))
        connection.start(queue: DispatchQueue(label: "NetworkConnection"))
    }

    func stop() {
        connection.stateUpdateHandler = nil
        connection.cancel()
        notifyConnectionStopped()
    }
}

// MARK: - Communication
private extension NetworkConnection {
    func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .ready:
            print("[NetworkConnection] Connection successful")
            notifyConnectionStarted()
            receive()
        case .failed(let error):
            stopWithError(error: error)
            stop()
        default:
            break
        }
    }

    func receive() {
        connection.receive(minimumIncompleteLength: 8, maximumLength: MTU) { [weak self] (data: Data?, context: NWConnection.ContentContext?, isComplete: Bool, error: NWError?) in
            guard let self = self else { return }

            if let data = data, !data.isEmpty {
                self.notifyDataReceived(data: data)
//                self.send(data: data)
            }

            if isComplete {
                self.stop()
            } else if let error = error {
                self.stopWithError(error: error)
            } else {
                self.receive()
            }
        }
    }

    func send(data: Data) {
        self.connection.send(content: data, completion: .contentProcessed( { [weak self] (error: Error?) in
            guard let self = self else { return }

            if let error = error {
                self.stopWithError(error: error)
                return
            }
            print("[NetworkConnection] Responding to connection, data: \(data as NSData)")
        }))
    }
}

// MARK: - Callback handling
private extension NetworkConnection {
    func stopWithError(error: Error) {
        connection.stateUpdateHandler = nil
        connection.cancel()
        notifyConnectionStopped(with: error)
    }

    func notifyConnectionStarted() {
        if let startClosure = didStartConnection {
            startClosure(self)
        }
    }

    func notifyDataReceived(data: Data) {
        if let dataReceivedClosure = self.didReceivedData {
            dataReceivedClosure(self, data)
        }
    }

    func notifyConnectionStopped(with error: Error? = nil) {
        if let stopClosure = didStopConnection {
            didStopConnection = nil
            stopClosure(self, error)
        }
    }
}

extension NetworkConnection: Hashable {
    static func == (lhs: NetworkConnection, rhs: NetworkConnection) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
