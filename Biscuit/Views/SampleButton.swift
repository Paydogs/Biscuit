//
//  SampleButton.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 22..
//

import SwiftUI
import Factory

struct SampleButton: View {
    typealias Action = ()->()
    var action: Action

    var body: some View {
        Button("Test button") { action() }
    }
}

struct LibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(
            SampleButton(action: {}),
            title: "Biscuit Sample Button",
            category: .control
        )
    }

    @LibraryContentBuilder
    func modifiers(base: SampleButton) -> [LibraryItem] {
        LibraryItem(
            base.sized(width: 100, height: 50)
        )
    }
}

extension SampleButton {
    func sized(width: CGFloat, height: CGFloat) -> some View {
        return self
            .frame(minWidth: width, maxWidth: width, minHeight: height, maxHeight: height)
    }
}
