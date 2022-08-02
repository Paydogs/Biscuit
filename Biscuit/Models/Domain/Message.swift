//
//  Message.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 25..
//

import Foundation

struct Message: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(bagelPacketId)
    }

    let bagelPacketId: String
    let project: Project
    let device: Device

    let url: String
    let statusCode: String
    let startDate: Date
    let endDate: Date

    let request: Request
    let response: Response
}


/*
 var url: String?
 var requestHeaders: [String: String]?
 var requestBody: String?
 var requestMethod: RequestMethod?

 var responseHeaders: [String: String]?
 var responseData: String?

 var statusCode: String?

 var startDate: Date?
 var endDate: Date?
 */
