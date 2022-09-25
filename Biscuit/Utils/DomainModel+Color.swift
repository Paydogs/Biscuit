//
//  DomainModel+Color.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 25..
//

import Foundation
import SwiftUI

extension StatusCode {
    var color: Color {
        switch code {
        case 200...299:
            return Colors.StatusCode.http2xx
        case 400...499:
            return Colors.StatusCode.http4xx
        default:
            return Colors.StatusCode.defaultColor
        }
    }
}

extension RequestMethod {
    var color: Color {
        switch self {
            case .get:
                return Colors.RequestMethod.get
            case .post:
                return Colors.RequestMethod.post
            case .put:
                return Colors.RequestMethod.put
            case .delete:
                return Colors.RequestMethod.delete
            case .patch:
                return Colors.RequestMethod.defaultColor
            case .head:
                return Colors.RequestMethod.defaultColor
            case .unknown:
                return Colors.RequestMethod.defaultColor
        }
    }
}
