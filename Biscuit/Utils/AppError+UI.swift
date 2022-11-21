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
            return Localized.AppError.cannotConnect
        }
    }
}
