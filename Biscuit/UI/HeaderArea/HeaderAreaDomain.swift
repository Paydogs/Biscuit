//
//  HeaderAreaDomain.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

import Combine

class HeaderAreaDomain: ObservableObject {
    @Published var projectTitle: String = ""
    @Published var projectList: [String] = []
    @Published var deviceTitle: String = ""
    @Published var deviceList: [String] = []
}
