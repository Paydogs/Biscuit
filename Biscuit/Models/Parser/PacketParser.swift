//
//  PacketParser.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 20..
//

import Foundation

struct PacketParser {
    func parsePacket(_ packet: BagelPacket, client: Client, received: Double) -> IncomingPacket {
        let projectDescriptor = mapProjectDescriptor(model: packet.project)
        let deviceDescriptor = mapDeviceDescriptor(packet.device, client: client)
        return IncomingPacket(projectDescriptor: projectDescriptor,
                              deviceDescriptor: deviceDescriptor,
                              packet: mapPacket(packet, received: received, project: projectDescriptor.id, deviceId: deviceDescriptor.deviceId))
    }
}

private extension PacketParser {
    func mapProjectDescriptor(model: BagelProjectModel?) -> ProjectDescriptor {
        guard let model = model,
              let projectName = model.projectName else { return ProjectDescriptor(id: "unknown", name: "unknown") }
        return ProjectDescriptor(id: projectName, name: projectName)
    }

    func mapDeviceDescriptor(_ device: BagelDeviceModel?, client: Client) -> DeviceDescriptor {
        guard let device = device else { return DeviceDescriptor.defaultValue() }
        return .init(deviceId: "\(device.deviceId ?? "THIS_SHOULD_NOT_HAPPEN")-\(client.id)" ,
                     name: device.deviceName ?? "",
                     description: device.deviceDescription ?? "",
                     ip: client.ip)
    }

    func mapPacket(_ packet: BagelPacket, received: Double, project: String, deviceId: String) -> Packet {
        .init(bagelPacketId: packet.packetId ?? "",
              deviceId: deviceId,
              project: project,
              received: received,
              pinned: false,
              url: packet.requestInfo?.url ?? "",
              statusCode: StatusCode(code: Int(packet.requestInfo?.statusCode ?? "-1") ?? -1),
              startDate: packet.requestInfo?.startDate ?? Date(timeIntervalSince1970: 0),
              endDate: packet.requestInfo?.endDate ?? Date(timeIntervalSince1970: 0),
              request: mapRequest(from: packet),
              response: mapResponse(from: packet))
    }

    func mapRequest(from packet: BagelPacket) -> Request {
        guard let source = packet.requestInfo else { return Request.defaultValue() }
        return .init(method: source.requestMethod ?? .unknown,
                     headers: source.requestHeaders ?? [:],
                     body: parseEncodedBodyToDictionary(base64String: source.requestBody),
                     prettyBody: parseEncodedBodyToFormattedString(base64String: source.requestBody))
    }

    func mapResponse(from packet: BagelPacket) -> Response {
        guard let source = packet.requestInfo else { return Response.defaultValue() }
        return .init(headers: source.responseHeaders ?? [:],
                     body: parseEncodedBodyToDictionary(base64String: source.responseData),
                     prettyBody: parseEncodedBodyToFormattedString(base64String: source.responseData),
                     rawBody: source.responseData)
    }

    func parseEncodedBodyToDictionary(base64String: String?) -> [String:Any]? {
        guard let data = base64String?.base64Data,
              let text = String(data: data, encoding: .utf8) else { return nil }

        let clean = text.replacingOccurrences(of: "\n", with: "")

        guard let data = clean.data(using: .utf8),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return nil }

        return dictionary
    }

    func parseEncodedBodyToFormattedString(base64String: String?) -> NSString? {
        guard let data = base64String?.base64Data,
              let object = try? JSONSerialization.jsonObject(with: data, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
