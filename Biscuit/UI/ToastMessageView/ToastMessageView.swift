//
//  ToastMessageView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 10..
//

import SwiftUI

struct ToastMessageView<ViewModel: ToastMessageViewModelInterface>: View {
    @StateObject var viewModel: ViewModel
    @State var opacity: Double = 1

    init(viewModel: ViewModel = ToastMessageViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            ForEach(viewModel.messageList, id: \.self) { message in
                ToastMessageItem(message: message)
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.5)))
            .animation(.easeOut, value: viewModel.messageList)
        }
    }
}

struct ToastMessageItem: View {
    var id = UUID().uuidString
    var message: String

    var body: some View {
        Text(message)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)
            .font(Fonts.defaultFont(sized: 20).swiftUIFont)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background {
                Colors.View.mainBackground
            }
            .cornerRadius(10)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//            .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.2)))
    }
}

struct ToastMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ToastMessageView(viewModel: MockToastMessageViewModel())
            .darkPreview(title: "Dark")
        ToastMessageView(viewModel: MockToastMessageViewModel())
            .lightPreview(title: "Light")
    }
}
