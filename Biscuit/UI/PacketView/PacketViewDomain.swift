//
//  PacketViewDomain.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Combine

class PacketViewDomain: ObservableObject {
    @Published var tabs: [RequestTab] = [.headers, .params, .body]
    @Published var asdtabs: [ResponseTab] = [.headers, .body]

    enum RequestTab: String {
        case headers = "Headers"
        case params = "Parameters"
        case body = "Body"
    }
    enum ResponseTab: String {
        case headers = "Headers"
        case body = "Body"
    }
}
