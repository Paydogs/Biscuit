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
    var packetBody: String

    var body: some View {
        TextEditor(text: .constant(packetBody))
            .textSelection(EnabledTextSelectability.enabled)
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview(packetBody: "Some text")
    }
}
