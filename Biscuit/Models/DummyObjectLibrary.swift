//
//  DummyObjectLibrary.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 09..
//

import Foundation

struct DummyObjectLibrary { }

// MARK: - Projects
extension DummyObjectLibrary {
    static func createProject1() -> Project {
        return Project(descriptor: ProjectDescriptor(id: "Project1", name: "Project1"),
                       devices: [createDeviceiPhone13(), createDeviceiPhone13Pro()])
    }
    static func createProject2() -> Project {
        return Project(descriptor: ProjectDescriptor(id: "Project2", name: "Project2"),
                       devices: [createDeviceiPhone14()])
    }
}
// MARK: - Devices
extension DummyObjectLibrary {
    static func createDeviceiPhone13() -> Device {
        return Device(descriptor: DeviceDescriptor(deviceId: "iPhone 13", name: "iPhone 13", description: "iPhone iOS 15.4", ip: "127.0.0.1:1234"),
                      packets: [createPacketBodyless()],
                      online: true)
    }
    static func createDeviceiPhone13Pro() -> Device {
        return Device(descriptor: DeviceDescriptor(deviceId: "iPhone 13 Pro", name: "iPhone 13 Pro", description: "iPhone iOS 15.4", ip: "127.0.0.1:1235"),
                      packets: [createPacketBodyless()],
                      online: false)
    }
    static func createDeviceiPhone14() -> Device {
        return Device(descriptor: DeviceDescriptor(deviceId: "iPhone 14", name: "iPhone 14", description: "iPhone iOS 16.0", ip: "127.0.0.1:1237"),
                      packets: [createPacketBodyless()],
                      online: true)
    }
}
// MARK: - Packets
extension DummyObjectLibrary {
    static func createPacket(bagelPacketId: String = UUID().uuidString,
                             received: Double = Double.random(in: 1665309433.9865642 ... 1665309933.999999),
                             url: String = "http://0.0.0.0:8882/api/v3/something/apicall1",
                             statusCode: StatusCode = .init(code: 200),
                             startDate: Date = Date.now,
                             endDate: Date = Date.now,
                             request: Request = createBodylessRequest(),
                             response: Response = createBodylessResponse()) -> Packet {
        return Packet.init(bagelPacketId: bagelPacketId,
                           received: received,
                           pinned: false,
                           url: url,
                           statusCode: statusCode,
                           startDate: startDate,
                           endDate: endDate,
                           request: request,
                           response: response)
    }
    static func createPacketBodyless() -> Packet {
        return createPacket(url: "http://0.0.0.0:8882/api/v3/something/apicall1",
                            statusCode: .init(code: 200),
                            request: createBodylessRequest(),
                            response: createBodylessResponse())
    }

    static func createPacketSimpleBody() -> Packet {
        return createPacket(received: 1665309453.9865642,
                            url: "http://0.0.0.0:8882/api/v3/something/apicall1",
                            statusCode: .init(code: 200),
                            request: createBodylessRequest(),
                            response: createSmallBodyResponse())
    }
}

// MARK: - Requests
extension DummyObjectLibrary {
    static func createBodylessRequest() -> Request {
        return Request(method: .get,
                       headers: ["Accept-Charset":"UTF-8",
                                 "Authorization":"Bearer eyJjdHkiOiJKV1QiLCJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiUlNBLU9BRVAtMjU2In0.aoLyzd4E1mP-zXjD4zf4mMBsGgXYcNE8q_uaMy9cZpBikopc908IbDVgJl5VEHxWmiMYxaFeseZfkwYbUZC3sgDtt5y9QfAVpsUVILL3pu3cJQg2Qq4MVWgoSvY67Gno7KCMHnrityicq858ubjzAJ8XiTr2ZYQCFbBEQYb3ETr-Q0v7Hh-EBsvTzQcnzgYIPEIt2Nb0JsA_DakdN_YrOrIrS7DdbFlfbjkkwwbvCkUmAEKbLoftodeB6jaHQ-u7ATwdV1ZXK_gFayz7HppeSH3-VLjWz3mQLMmgL4iMIuD0rMUVV78LUPR2FBKQYpJL3BKTqCLBGt3u4lOAwTziSw.5pFshpKWEj396V13.d5iUaiUlzikH75KMMBUeF5_hD5jIuRZsYq6xVQ89VqfmrfNVU1iqy7JfwndzV6zDKZ8NWDgMAQvb9fupBDCEyCahkqsN8194PjHhn_di4YhMJB764uNNXeKONymw7GjVibwRWa382lpg5fXCkiuA7KrsxuX38B-6pQ1_R5QkaazyTPdnqZ6ZuyxAjkEnFtqMYVWRkhLvMWaApXm66BBerGMvTS6hPZw5KFUSocWZwBEESUStVrnkbB5w5iJwO6KTy_zXijJl10ZctvzJ-UJHBtg3K8T12JATxDWYg3ihIJhipuV-KxoahD60_nxa5Q0z8prxzxS23z7si_jhR90HYjwPhweN9sYQY4ZUNE-QoFs9nhYH9uwK-EOA8DecjWKs5-njn2UBy1X1eZWZj2kybN8wvQMpu5j97IJHuMn3s9n6Uol3JUhZblAdTPhbKS1WDKLUeVFSLaIdxfLHKookOk5vahPu8XR1vmjaG2jAOCbikbEuFNC9428XX2fQF6obNxLFGpn-8E3oFUqgd855b1BhWc8M9ixwX1OG8Ruq2Ct9khm02uWyEgQuB-7SRdqz4clUZkSFiYLQK5q8gqu0hyfuEku1Tf-edIuS_JPJdADVGfooSrHjEuvpUkfNGL8X7u5uNaa9PjlJx_NlcrHypC2nBvGbufA3gQeXmwtDf-Kln-YyGEr-0pX9qWyCs6Co4y5QHOobV5oTot_Y_0OcUmxmsBH8J1I3oe9Szxy5Fks46D0bYkrlQ76dq1aC7Ug7-7wYrwEj1zdRcUGpa7-X49CvJPRrmGP0L98_Yzr4IOLN6tXgrU6hM9RTAbgugJdAGqqxFKVtgtOyPswnTNMHbKkIn6w1V2v4QEkknIDY5sJ-XDmtJUiIfDO1qwtqgcu-t_yLInpCqSC4_xizwZ7W3XkbKOYOTM7Id3L9_20CpIRwV5fJsAjWhSnPLQbz9fZS6vfKHCOMlnQ3FNj0O7jJ.NABZm8AZcbuBCV-pl-wiIQ"],
                       body: nil)
    }
}

// MARK: - Responses
extension DummyObjectLibrary {
    static func createBodylessResponse() -> Response {
        Response(headers: ["Connection" : "keep-alive",
                           "Transfer-Encoding":"Identity",
                           "Content-Type":"application/json",
                           "Server":"stubby/4.0.0 node/v12.8.0 (darwin x64)"],
                 body: nil,
                 prettyBody: nil,
                 rawBody: nil)
    }

    static func createSmallBodyResponse() -> Response {
        return Response(headers: ["Connection" : "keep-alive",
                                  "Transfer-Encoding":"Identity",
                                  "Content-Type":"application/json",
                                  "Server":"stubby/4.0.0 node/v12.8.0 (darwin x64)"],
                        body: ["testInt" : 13,
                               "testString" : "sample",
                               "testBool" : true],
                        prettyBody: NSString("{\n  \"testInt\" : 13\n  \"testString\" : \"sample\"\n\n  \"testBool\" : true\"\n\n}"),
                        rawBody: String("e1xuICBcInRlc3RJbnRcIiA6IDEzXG4gIFwidGVzdFN0cmluZ1wiIDogXCJzYW1wbGVcIlxuXG4gIFwidGVzdEJvb2xcIiA6IHRydWVcIlxuXG59"))
    }
}
