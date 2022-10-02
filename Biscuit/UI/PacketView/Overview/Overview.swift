//
//  Overview.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

struct Overview: View {
    var packet: Packet?
    var body: some View {
        VStack {
            Text(String(packet?.response.prettyBody ?? ""))
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview(packet: nil)
    }
}
