//
//  PostAppErrorUseCaseInterface.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 12..
//

protocol PostAppErrorUseCaseInterface {
    func execute(errors: [AppError])
}
