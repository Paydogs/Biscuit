//
//  HeaderView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 26..
//

import Combine
import SwiftUI
import Factory

struct HeaderView<ViewModel: HeaderViewViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = HeaderViewViewModel()) {
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

            Spacer()
        }
        .background(Colors.Background.panelBackground.opacity(0.2))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(viewModel: MockHeaderViewViewModel())
    }
}
