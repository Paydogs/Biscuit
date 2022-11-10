//
//  AppError+UI.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 12..
//

extension AppError {
    func localizedMessage() -> String {
        switch self {
            case .cannotConnect:
            return "Error during connection. Is the port open? Maybe Bagel is running"
        }
    }
}
