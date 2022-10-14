//
//  DictionaryMerge.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 14..
//

import Foundation

extension Dictionary {
    mutating func with(_ dictionary: Dictionary) {
        return self.merge(dictionary, uniquingKeysWith: { (current, _) in current })
    }
}
