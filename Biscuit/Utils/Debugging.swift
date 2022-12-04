//
//  Debugging.swift
//  StateDemo
//
//  Created by Michael Long on 7/27/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI

/// A Sample instance tracking utility from Michael Long, to track when insances are created, called and disposed in a SwiftUI lifecyle
/// https://medium.com/swlh/deep-inside-views-state-and-performance-in-swiftui-d23a3a44b79
class InstanceTracker {
    static var count: Int {
        counter += 1
        return counter
    }
    let instance = InstanceTracker.count
    let name: String
    private static var counter: Int = 0
    private static var indent: Int = 0
    init(_ name: String) {
        self.name = name
        self("[InstanceTracker] \(name).init() #\(instance)")
    }
    deinit {
        self("[InstanceTracker] \(name).deinit() #\(instance)")
    }
    func callAsFunction<Result>(_ message: String? = nil, _ result: () -> Result) -> Result {
        self("[InstanceTracker] \(name).body #\(instance) {")
        Self.indent += 2
        if let message = message {
            self(message)
        }
        defer {
            Self.indent -= 2
            self("}")
        }
        return result()
    }
    func callAsFunction(_ string: String) {
        print(String(repeating: " ", count: Self.indent) + string)
    }
}

struct DebugView<WrappedView:View>: View {
    let instance = InstanceTracker.count
    let view: WrappedView
    init(_ view: WrappedView) {
        self.view = view
        print("[InstanceTracker] \(WrappedView.self).init #\(instance)")
    }
    var body: some View {
        print("[InstanceTracker] \(WrappedView.self).body #\(instance)")
        return view
    }
}
