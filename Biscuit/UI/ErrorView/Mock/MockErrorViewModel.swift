//
//  MockErrorViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 09..
//

class MockErrorViewModel: ErrorViewModelInterface {
    var errorList: [String] {
        ["Error during connection. Is the port open? Maybe Bagel is running"]
    }

}
