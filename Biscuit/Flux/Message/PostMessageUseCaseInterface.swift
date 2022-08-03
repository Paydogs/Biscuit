//
//  PostMessageUseCaseInterface.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 03..
//

import Foundation

protocol PostMessageUseCaseInterface {
    func execute(message: Message)
}
