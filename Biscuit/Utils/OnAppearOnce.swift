//
//  OnAppearOnce.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 03..
//

// Extension By Michael Long
// https://betterprogramming.pub/swiftui-were-loading-we-re-loading-7d689fa8b0c7
//

import SwiftUI

extension View {
    func onAppearOnce(_ action: @escaping () -> ()) -> some View {
        self.modifier(OnAppearOnceModifier(action: action))
    }
}

private struct OnAppearOnceModifier: ViewModifier {
    let action: () -> ()
    @State private var appearOnce = true
    func body(content: Content) -> some View {
        content
            .onAppear {
                if appearOnce {
                    appearOnce = false
                    action()
                }
            }
    }
}
