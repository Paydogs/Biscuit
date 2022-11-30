//
//  RequestView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

struct RequestView<ViewModel: RequestViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = RequestViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack() {
            RequestHeadersView(requestHeaders: viewModel.requestHeaders)
            RequestBodyView(attributedText: viewModel.requestBody)
        }
        .frame(maxWidth: .infinity)
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView(viewModel: MockRequestViewModel())
            .darkPreview(title: "Dark")
        RequestView(viewModel: MockRequestViewModel())
            .lightPreview(title: "Light")
    }
}
