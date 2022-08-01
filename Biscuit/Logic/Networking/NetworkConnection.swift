//
//  NetworkConnection.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 24..
//

import Foundation
import Network

private enum Stage {
    case striding
    case receiving
}

class NetworkConnection {
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

        connection.start(queue: .global(qos: .default))
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
            listen(to: .striding)
        case .failed(let error):
            stopWithError(error: error)
            stop()
        default:
            break
        }
    }

    func listen(to stage: Stage, bytes: Int? = nil) {
        let readAmount = stage == .striding ? Constants.stride : bytes ?? 1
        connection.receive(minimumIncompleteLength: 1, maximumLength: readAmount) { [weak self] (data: Data?, context: NWConnection.ContentContext?, isComplete: Bool, error: NWError?) in
            guard let self = self else { return }
            if stage == .striding, let strideData = data {
                let receivingLength = self.getNextLength(from: strideData)
                self.listen(to: .receiving, bytes: receivingLength)
                return
            }

            if let receivedData = data, !receivedData.isEmpty {
                self.notifyDataReceived(data: receivedData)
            }

            if isComplete {
                self.stop()
            } else if let error = error {
                self.stopWithError(error: error)
            } else {
                self.listen(to: .striding)
            }
        }
    }

    func getNextLength(from data: Data) -> Int {
        var length = 0
        memcpy(&length, ([UInt8](data)), Constants.stride)
        return length
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

private extension NetworkConnection {
    struct Constants {
        static let stride = MemoryLayout<UInt64>.stride
    }
}
