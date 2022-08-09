//
//  Factory+Extension.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 09..
//

import Foundation
import Factory

extension Factory {
    func resolve() -> T {
        return self.callAsFunction()
    }
}
