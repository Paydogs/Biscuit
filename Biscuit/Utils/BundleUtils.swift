//
//  BundleUtils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 29..
//

import Foundation

enum BundleKeys: String {
    case appName = "CFBundleName"
    case version = "CFBundleShortVersionString"
    case build = "CFBundleVersion"
    case copyright = "NSHumanReadableCopyright"
}

struct BundleUtils {
    func bundleValue(for key: BundleKeys) -> String {
        return Bundle.main.infoDictionary?[key.rawValue] as? String ?? ""
    }
}
