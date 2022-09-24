//
//  PacketParser.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

import Foundation

struct PacketParser {
    func parsePacket(_ packet: BagelPacket, client: String) -> IncomingPacket {
        .init(project: mapProject(model: packet.project),
              device: mapDevice(packet.device, client: client),
              packet: mapPacket(packet))
    }
}

private extension PacketParser {
    func mapProject(model: BagelProjectModel?) -> ProjectDescriptor {
        guard let model = model,
              let projectName = model.projectName else { return ProjectDescriptor(id: "unknown", name: "unknown") }
        return ProjectDescriptor(id: projectName, name: projectName)
    }

    func mapDevice(_ device: BagelDeviceModel?, client: String) -> DeviceDescriptor {
        guard let device = device else { return DeviceDescriptor.defaultValue() }
        return .init(deviceId: device.deviceId ?? "",
                     name: device.deviceName ?? "",
                     description: device.deviceDescription ?? "",
                     ip: client)
    }

    func mapPacket(_ packet: BagelPacket) -> Packet {
        .init(bagelPacketId: packet.packetId ?? "",
              received: Double(Date().timeIntervalSince1970),
              url: packet.requestInfo?.url ?? "",
              statusCode: packet.requestInfo?.statusCode ?? "",
              startDate: packet.requestInfo?.startDate ?? Date(timeIntervalSince1970: 0),
              endDate: packet.requestInfo?.endDate ?? Date(timeIntervalSince1970: 0),
              request: mapRequest(from: packet),
              response: mapResponse(from: packet))
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
