//
//  MockLogViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//
import Foundation

class MockLogViewModel: LogViewModelInterface {
    var packets: [PacketTableRow] {
        [.init(id: "Test1111", status: "200", statusColor: Colors.StatusCode.http2xx, method: "GET", methodColor: Colors.RequestMethod.get, url: "http://0.0.0.0:8882/api/v10/login/fingerprint/ios", date: Date.now.formatted()),
         .init(id: "Test1112", status: "402", statusColor: Colors.StatusCode.http4xx, method: "POST", methodColor: Colors.RequestMethod.post, url: "http://0.0.0.0:8882/api/v10/login/fingerprint/ios", date: Date.now.formatted()),
         .init(id: "Test1113", status: "500", statusColor: Colors.StatusCode.defaultColor, method: "PUT", methodColor: Colors.RequestMethod.put, url: "http://0.0.0.0:8882/api/v10/login/fingerprint/ios", date: Date.now.formatted()),
         .init(id: "Test1114", status: "200", statusColor: Colors.StatusCode.http2xx, method: "DELETE", methodColor: Colors.RequestMethod.delete, url: "http://0.0.0.0:8882/api/v10/login/fingerprint/ios", date: Date.now.formatted()),
         .init(id: "Test1115", status: "204", statusColor: Colors.StatusCode.http2xx, method: "PATCH", methodColor: Colors.RequestMethod.defaultColor, url: "http://0.0.0.0:8882/api/v10/login/fingerprint/ios", date: Date.now.formatted())]
    }

    func selectPackets(identifiers: [String]) { }
    func exportPackets() { }
    func filterUrl(url: String) { }
}