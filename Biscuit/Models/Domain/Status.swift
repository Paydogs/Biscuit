//
//  Status.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import SwiftUI

enum ClientStatus {
    case active
    case offline
}

extension ClientStatus {
    func localizedValue() -> String {
        switch self {
            case .active:
                return "Active"
            case .offline:
                return "Offline"
        }
    }

    func color() -> Color {
        switch self {
            case .active:
                return Colors.Status.activeStatus
            case .offline:
                return Colors.Status.offlineStatus
        }
    }
}
