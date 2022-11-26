//
//  SmallActionButton.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 08..
//

import SwiftUI
import Factory

struct SmallActionButton: View {
    typealias Action = ()->()
    var data: Data
    var event: Event?

    var body: some View {
        Button {
            event?.action()
        } label: {
            Image(systemName: data.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(8)
        }
        .buttonStyle(.plain)
        .help(data.help)
        .frame(width: 32, height: 32, alignment: .center)
    }
}

extension SmallActionButton {
    struct Data {
        var icon: String
        var help: String
    }
}

extension SmallActionButton {
    struct Event {
        var action: Action
    }
}

struct SmallActionButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallActionButton(data: SmallActionButton.Data(icon: IconName.clipboard,
                                                       help: "Help"))
        .darkPreview(title: "Dark")
        SmallActionButton(data: SmallActionButton.Data(icon: IconName.clipboard,
                                                       help: "Help"))
        .lightPreview(title: "Light")

    }
}
