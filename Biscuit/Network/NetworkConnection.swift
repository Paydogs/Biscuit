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

//        receive()
//        tempReceiveMessageDiscontiguous()
//        tempReceiveMessage()
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
            receive()
//            receiveMessage()
        case .failed(let error):
            stopWithError(error: error)
            stop()
        default:
            break
        }
    }

    func receiveMessage() {
        connection.receiveMessage { (data: Data?, _, isComplete: Bool, error: NWError?) in
            if let data = data, !data.isEmpty {
                let message = String(decoding: data, as: UTF8.self)
                NSLog("[NetworkConnection][\(self.id)] Received message: \(message)")
            }
        }
    }

    func receive() {
        connection.receive(minimumIncompleteLength: 1, maximumLength: MTU) { [weak self] (data: Data?, _, isComplete: Bool, error: NWError?) in
            guard let self = self else { return }
            NSLog("=================")
            NSLog("[NetworkConnection][\(self.id)] isComplete: \(isComplete)")
            NSLog("[NetworkConnection][\(self.id)] error: \(error)")

            if let data = data, !data.isEmpty {
                NSLog("[NetworkConnection][\(self.id)] Received data: \(data)")
                let peak = String(data: data, encoding: .utf8)
                NSLog("[NetworkConnection][\(self.id)] peak: \(peak)")
                let newData = self.removeFirstBytes(data: data)
                let peak2 = String(data: newData, encoding: .utf8)
                NSLog("[NetworkConnection][\(self.id)] peak2: \(peak2)")
                let parsed = self.parseBody(data: newData)
                NSLog("[NetworkConnection][\(self.id)] parsed: \(parsed)")
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

    func removeFirstBytes(data: Data) -> Data {
        let range: Range<Data.Index> = 8 ..< data.endIndex
        let newData = data.subdata(in: range)
        return newData
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
    func tempReceiveMessageDiscontiguous() {
        connection.receiveMessageDiscontiguous { [weak self] (completeContent, contentContext, isComplete, error) in
            guard let self = self else { return }

            NSLog("[receiveMessageDiscontiguous] Content isComplete: \(isComplete)")
            if let data = completeContent, !data.isEmpty {
                NSLog("[receiveMessageDiscontiguous][\(self.id)] completeContent: \(data)")
//                self.send(data: data)
            }
            if let contentContext = contentContext {
                NSLog("[receiveMessageDiscontiguous][\(self.id)] contentContext: \(contentContext)")
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

    func tempReceiveMessage() {
        connection.receiveMessage { [weak self] (completeContent, contentContext, isComplete, error) in
            guard let self = self else { return }

            NSLog("[receiveMessage] Content isComplete: \(isComplete)")
            if let data = completeContent, !data.isEmpty {
                NSLog("[receiveMessageDiscontiguous][\(self.id)] completeContent: \(data)")
                self.send(data: data)
            }
            if let contentContext = contentContext {
                NSLog("[receiveMessage][\(self.id)] contentContext: \(contentContext)")
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
}

extension NetworkConnection: Hashable {
    static func == (lhs: NetworkConnection, rhs: NetworkConnection) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
