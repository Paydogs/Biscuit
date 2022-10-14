//
//  NSAttributedString+Join.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 14..
//

import Foundation

extension Sequence where Iterator.Element == NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if r.length > 0 {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    func joined(separator: String = "") -> NSAttributedString {
        return self.joined(separator: NSAttributedString(string: separator))
    }
}
