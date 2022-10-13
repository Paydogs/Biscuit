//
//  AttributedTextView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 14..
//

import SwiftUI

struct AttributedTextView: NSViewRepresentable {
    typealias NSViewType = NSScrollView

    let attributedText: NSAttributedString?

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSTextView.scrollableTextView()

        let textView = scrollView.documentView as! NSTextView
        textView.drawsBackground = false
        textView.isSelectable = true

        return scrollView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
        let textView = (nsView.documentView as! NSTextView)

        if let attributedText = attributedText,
            attributedText != textView.attributedString() {
            textView.textStorage?.setAttributedString(attributedText)
        }

        if let lineLimit = context.environment.lineLimit {
            textView.textContainer?.maximumNumberOfLines = lineLimit
        }
    }
}
