//
//  Overview.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }

    }
}

struct Overview: View {
    var packetBody: NSAttributedString

    var body: some View {
        AttributedTextView(attributedText: packetBody)
            .padding()
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview(packetBody: NSAttributedString(string: "Some text"))
    }
}
