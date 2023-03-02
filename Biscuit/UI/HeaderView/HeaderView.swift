//
//  HeaderView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

import Combine
import SwiftUI
import Factory

struct HeaderView<ViewModel: HeaderViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = HeaderViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        HStack {
            StandardPicker(data: StandardPicker.Content(title: Localized.HeaderView.projectTitle,
                                                        values: viewModel.projectList),
                           event: StandardPicker.Events(itemSelected: { selected in
                viewModel.projectSelected(identifier: selected.id)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))

            StandardPicker(data: StandardPicker.Content(title: Localized.HeaderView.deviceTitle,
                                                        values: viewModel.deviceList),
                           event: StandardPicker.Events(itemSelected: { selected in
                viewModel.deviceSelected(identifier: selected.id)
            }))
            .frame(width: 250, height: 40, alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
            SmallActionButton(data: SmallActionButton.Data(icon: IconName.clearDevices,
                                                           help: Localized.HeaderView.clearOfflineDevices),
                              event: SmallActionButton.Event(action: {
                viewModel.deleteOfflineDevices()
                }))
            Spacer()
            SmallActionButton(data: SmallActionButton.Data(icon: IconName.toggleView,
                                                           help: Localized.HeaderView.toggleHelp),
                              event: SmallActionButton.Event(action: {
                viewModel.toggleSidebar()
                }))
        }
        .background(Colors.HeaderView.background)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(viewModel: MockHeaderViewModel())
            .darkPreview(title: "Dark")
        HeaderView(viewModel: MockHeaderViewModel())
            .lightPreview(title: "Light")
    }
}
