//
//  ResponseBodyView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import SwiftUI

struct ResponseBodyView: View {
    var attributedText: NSAttributedString
    @State var isOpen: Bool = true

    var body: some View {
        DropdownButton(data: DropdownButton.Data(title: "Response Body",
                                                 help: "Show response body"),
                       event: DropdownButton.Event(action: { isOpen in
            self.isOpen = isOpen
        }))
        AttributedTextView(attributedText: attributedText)
            .background(Colors.Overview.background)
            .frame(maxHeight: isOpen ? .infinity : 0)
        Divider()
    }
}

struct ResponseBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseBodyView(attributedText: MockResponseViewModel().responseBody)
            .darkPreview(title: "Dark")
        ResponseBodyView(attributedText: MockResponseViewModel().responseBody)
            .lightPreview(title: "Light")
    }
}
