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
            Button {
                isOpen.toggle()
            } label: {
                Text("Body")
            }
            .padding(10)
            .buttonStyle(.plain)
            .background(.gray)
            AttributedTextView(attributedText: attributedText)
                .background(Colors.Overview.background)
                .frame(maxHeight: isOpen ? .infinity : 0)
        }
    }
}

struct RequestBodyView_Previews: PreviewProvider {
    static var previews: some View {
        RequestBodyView(attributedText: MockRequestViewModel().requestBody)
    }
}
