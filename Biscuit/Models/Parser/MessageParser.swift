//
//  MessageParser.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct MessageParser {
    func parseMessage(from packet: BagelPacket, client: String) -> Message {
        return .init(bagelPacketId: packet.packetId ?? "",
                     project: mapProject(model: packet.project),
                     device: mapDevice(packet.device, client: client),
                     url: packet.requestInfo?.url ?? "",
                     statusCode: packet.requestInfo?.statusCode ?? "",
                     startDate: packet.requestInfo?.startDate ?? Date(timeIntervalSince1970: 0),
                     endDate: packet.requestInfo?.endDate ?? Date(timeIntervalSince1970: 0),
                     request: mapRequest(from: packet),
                     response: mapResponse(from: packet))
    }
}

private extension MessageParser {
    func mapProject(model: BagelProjectModel?) -> Project {
        guard let model = model,
              let projectName = model.projectName else { return Project(id: "unknown", name: "unknown") }
        return Project(id: projectName, name: projectName)
    }

    func mapDevice(_ device: BagelDeviceModel?, client: String) -> Device {
        guard let device = device else { return Device.defaultValue() }
        return .init(deviceId: device.deviceId ?? "",
                     name: device.deviceName ?? "",
                     description: device.deviceDescription ?? "",
                     ip: client)
    }

    func mapRequest(from packet: BagelPacket) -> Request {
        guard let source = packet.requestInfo else { return Request.defaultValue() }
        return .init(method: source.requestMethod ?? .unknown,
                     headers: source.requestHeaders ?? [:],
                     body: source.requestBody)

    }

    func mapResponse(from packet: BagelPacket) -> Response {
        guard let source = packet.requestInfo else { return Response.defaultValue() }
        return .init(headers: source.responseHeaders ?? [:],
                     body: nil,
                     rawBody: source.responseData)
    }
}
