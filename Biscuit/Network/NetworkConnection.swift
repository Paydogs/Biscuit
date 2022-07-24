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
    var didStopConnection: ((NetworkConnection, Error?) -> Void)? = nil

    init(with connection: NWConnection) {
        self.connection = connection
        self.id = UUID().uuidString
    }

    func start() {
        NSLog("[NetworkConnection][\(id)] Connection starting...")
        connection.stateUpdateHandler = { [weak self] (state: NWConnection.State) in
            self?.stateDidChange(to: state)
        }

        receive()
        connection.start(queue: .global(qos: .background))
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
            NSLog("[NetworkConnection][\(id)] Connection successful")
                notifyConnectionStarted()
        case .waiting(let error),
             .failed(let error):
            stopWithError(error: error)
            stop()
        default:
            break
        }
    }

    func receive() {
        connection.receive(minimumIncompleteLength: 1, maximumLength: MTU) { [weak self] (data, _, isComplete, error) in
            guard let self = self else { return }

            if let data = data, !data.isEmpty {
                NSLog("[NetworkConnection][\(self.id)] Received something \(data)")
                self.send(data: data)
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
            NSLog("[NetworkConnection][\(self.id)] Responding to connection, data: \(data as NSData)")
        }))
    }
}

// MARK: - Data processing
private extension NetworkConnection {
    func parseBody(data: Data) -> BagelPacket? {

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970

        do {
            let bagelPacket = try jsonDecoder.decode(BagelPacket.self, from: data)
            return bagelPacket

        } catch {
            print(error)
            return nil
        }
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

    func notifyConnectionStopped(with error: Error? = nil) {
        if let stopClosure = didStopConnection {
            didStopConnection = nil
            stopClosure(self, error)
        }
    }
}

private extension NetworkConnection {
    func tempReceives() {
        connection.receiveMessageDiscontiguous { (completeContent, contentContext, isComplete, error) in
            if let completeContent = completeContent {
                NSLog("Content Received: \(completeContent)")
            }
            NSLog("Content isComplete: \(isComplete)")
        }
        connection.receiveMessage { (completeContent, contentContext, isComplete, error) in
            if let completeContent = completeContent {
                NSLog("Content Received 2: \(completeContent)")
            }
            NSLog("Content isComplete 2: \(isComplete)")
        }
        connection.receive(minimumIncompleteLength: 1, maximumLength: MTU) { (content, contentContext, isComplete, error) in
            if let content = content {
                NSLog("Content Received 3: \(content)")
            }
            NSLog("Content isComplete 3: \(isComplete)")
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
