//
//  ResponseHeadersView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 30..
//

import SwiftUI

struct ResponseHeadersView<ViewModel: ResponseHeadersViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = ResponseHeadersViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Table(viewModel.responseHeaders) {
            TableColumn(Localized.ResponseView.Header.TableColumn.key, value: \.key)
            TableColumn(Localized.ResponseView.Header.TableColumn.value, value: \.value)
        }
    }
}

struct ResponseHeadersView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseHeadersView(viewModel: MockResponseHeadersViewModel())
    }
}
