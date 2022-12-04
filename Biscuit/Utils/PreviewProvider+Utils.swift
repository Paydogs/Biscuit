//
//  PreviewProvider+Utils.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 12..
//

import SwiftUI

/// Defines a Light Mode Preview style
struct LightPreview: ViewModifier {
    var title: String
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
            .previewDisplayName(title)
            .preferredColorScheme(.light)
    }
}

/// Defines a Dark Mode Preview style
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
    /// Applies a Dark Mode Preview modifier
    func darkPreview(title: String) -> some View {
        modifier(DarkPreview(title: title))
    }
    /// Applies a Light Mode Preview modifier
    func lightPreview(title: String) -> some View {
        modifier(LightPreview(title: title))
    }
}
