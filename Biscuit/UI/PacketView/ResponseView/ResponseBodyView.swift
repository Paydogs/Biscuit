//
//  ResponseBodyView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import SwiftUI

struct ResponseBodyView<ViewModel: ResponseBodyViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = ResponseBodyViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AttributedTextView(attributedText: viewModel.responseBody)
            .background(Colors.Overview.background)
    }
}

struct ResponseBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseBodyView(viewModel: MockResponseBodyViewModel())
            .darkPreview(title: "Dark")
        ResponseBodyView(viewModel: MockResponseBodyViewModel())
            .lightPreview(title: "Light")
    }
}
