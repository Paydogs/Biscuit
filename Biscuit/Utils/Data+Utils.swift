//
//  Data+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 25..
//

import Foundation

extension Data {
    /// Simple utility method to remove the first n bytes of a Data
    func removeFirstBytes(_ number: Int) -> Data {
        let range: Range<Data.Index> = number ..< endIndex
        return subdata(in: range)
    }
}
