//
//  PreviewProvider+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 12..
//

import SwiftUI

struct LightPreview: ViewModifier {
    var title: String
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
            .previewDisplayName(title)
            .preferredColorScheme(.light)
    }
}

struct DarkPreview: ViewModifier {
    var title: String
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
            .previewDisplayName(title)
            .preferredColorScheme(.dark)
    }
}

extension View {
    func darkPreview(title: String) -> some View {
        modifier(DarkPreview(title: title))
    }
    func lightPreview(title: String) -> some View {
        modifier(LightPreview(title: title))
    }
}
