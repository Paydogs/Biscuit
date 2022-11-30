//
//  DropdownButton.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import SwiftUI
import Factory

struct DropdownButton: View {
    typealias Action = (Bool)->()
    var data: Data
    var event: Event?

    @State var isOpen: Bool = true

    var body: some View {
        Button {
            isOpen.toggle()
            event?.action(isOpen)
        } label: {
            Label(data.title, systemImage: isOpen ? IconName.chevronDown : IconName.chevronUp)
                .labelStyle(ReversedStretchedLabelStyle())
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .help(data.help)
        .frame(maxWidth: .infinity)
    }
}

extension DropdownButton {
    struct Data {
        var title: String
        var help: String
    }
}

extension DropdownButton {
    struct Event {
        var action: Action
    }
}

struct DropdownButton_Previews: PreviewProvider {
    static var previews: some View {
        DropdownButton(data: DropdownButton.Data(title: "Button 1",
                                                 help: "Help"))
        .darkPreview(title: "Dark")
        DropdownButton(data: DropdownButton.Data(title: "Button 1",
                                                 help: "Help"))
        .lightPreview(title: "Light")

    }
}
