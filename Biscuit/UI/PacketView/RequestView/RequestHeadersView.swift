//
//  RequestHeadersView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import SwiftUI

struct RequestHeadersView: View {
    var requestHeaders: [HeaderRow]
    @State var isOpen: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            DropdownButton(data: DropdownButton.Data(title: "Request Headers",
                                                     help: "Show request headers"),
                           event: DropdownButton.Event(action: { isOpen in
                self.isOpen = isOpen
            }))
            Table(requestHeaders) {
                TableColumn(Localized.ResponseView.Header.TableColumn.key, value: \.key)
                TableColumn(Localized.ResponseView.Header.TableColumn.value, value: \.value)
            }
            .frame(maxHeight: isOpen ? .infinity : 0)
            Divider()
        }
    }
}

struct RequestHeadersView_Previews: PreviewProvider {
    static var previews: some View {
        RequestHeadersView(requestHeaders: MockRequestViewModel().requestHeaders)
    }
}
