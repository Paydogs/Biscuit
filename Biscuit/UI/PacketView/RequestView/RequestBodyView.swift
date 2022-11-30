//
//  RequestBodyView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..s
//

import SwiftUI

struct RequestBodyView: View {
    var attributedText: NSAttributedString
    @State var isOpen: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            DropdownButton(data: DropdownButton.Data(title: "Request Body",
                                                     help: "Show request body"),
                           event: DropdownButton.Event(action: { isOpen in
                self.isOpen = isOpen
            }))
            AttributedTextView(attributedText: attributedText)
                .background(Colors.Overview.background)
                .frame(maxHeight: isOpen ? .infinity : 0)
            Divider()
        }
    }
}

struct RequestBodyView_Previews: PreviewProvider {
    static var previews: some View {
        RequestBodyView(attributedText: MockRequestViewModel().requestBody)
    }
}
