//
//  MessageParser.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

import Foundation

struct MessageParser {
    func parseMessage(from packet: BagelPacket) -> Message {
        return .init(bagelPacketId: packet.packetId ?? "",
                     project: mapProjectName(model: packet.project),
                     device: mapDevice(packet.device),
                     url: packet.requestInfo?.url ?? "",
                     statusCode: packet.requestInfo?.statusCode ?? "",
                     startDate: packet.requestInfo?.startDate ?? Date(timeIntervalSince1970: 0),
                     endDate: packet.requestInfo?.endDate ?? Date(timeIntervalSince1970: 0),
                     request: mapRequest(from: packet),
                     response: mapResponse(from: packet))
    }
}

private extension MessageParser {
            func mapProjectName(model: BagelProjectModel?) -> String {
                guard let model = model else { return "" }
                return model.projectName ?? ""
            }
    func mapDevice(_ device: BagelDeviceModel?) -> Device {
        guard let device = device else { return Device.defaultValue() }
        return .init(deviceId: device.deviceId ?? "",
                     name: device.deviceName ?? "",
                     description: device.deviceDescription ?? "")
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
                     body: source.responseData)
    }
}
