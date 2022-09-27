//
//  PacketView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 28..
//

import Combine
import SwiftUI
import Factory

struct PacketView: View {
    @ObservedObject var domain: PacketViewDomain
    var eventHandler: PacketViewEventHandling

    @State private var selectedTab: String = ""

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Response")
                Text("Request")
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .frame(height: 25, alignment: .top)
            Picker("", selection: $selectedTab) {
                Text("Body")
                Text("Headers")
                Text("Parameters")
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .frame(height: 25, alignment: .top)
            Spacer()
        }
        .frame(idealWidth: 300)
    }
}

struct PacketView_Previews: PreviewProvider {
    static var previews: some View {
        PacketView(domain: createDummyDomain(),
                   eventHandler: DummyHandler())
    }
}
