//
//  ErrorView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 09..
//

import SwiftUI

struct ErrorView<ViewModel: ErrorViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = ErrorViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ForEach(viewModel.errorList, id: \.self) { error in
            Text(error)
                .font(Fonts.plain.swiftUIFont)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background {
                    Color.red
                }
                .cornerRadius(10)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
            .darkPreview(title: "Dark")
        ErrorView()
            .lightPreview(title: "Light")
    }
}
