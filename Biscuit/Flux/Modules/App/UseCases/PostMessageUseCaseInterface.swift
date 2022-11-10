//
//  PostMessageUseCaseInterface.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 10..
//

protocol PostMessageUseCaseInterface {
    func execute(message: String)
    func execute(message: String, duration: Double)
}
