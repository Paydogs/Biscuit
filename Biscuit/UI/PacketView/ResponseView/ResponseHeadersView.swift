//
//  ResponseHeadersView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import SwiftUI

struct ResponseHeadersView: View {
    var responseHeaders: [HeaderRow]
    @State var isOpen: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            DropdownButton(data: DropdownButton.Data(title: "Response Headers",
                                                     help: "Show response headers"),
                           event: DropdownButton.Event(action: { isOpen in
                self.isOpen = isOpen
            }))
            Table(responseHeaders) {
                TableColumn(Localized.ResponseView.Header.TableColumn.key, value: \.key)
                TableColumn(Localized.ResponseView.Header.TableColumn.value, value: \.value)
            }
            .frame(maxHeight: isOpen ? .infinity : 0)
            Divider()
        }
    }
}

struct ResponseHeadersView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseHeadersView(responseHeaders: MockResponseViewModel().responseHeaders)
    }
}
