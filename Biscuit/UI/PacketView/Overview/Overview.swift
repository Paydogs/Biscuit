//
//  Overview.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

struct Overview: View {
    var packetBody: String?
    var body: some View {
        ScrollView([.vertical]) {
            Text(String(packetBody ?? ""))
                .textSelection(EnabledTextSelectability.enabled)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview(packetBody: "Some text")
    }
}
