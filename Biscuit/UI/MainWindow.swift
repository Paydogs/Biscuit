//
//  MainWindow.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI
import Factory
import Combine

struct MainWindow<ViewModel: MainWindowViewModelInterface>: View {
    @StateObject var viewModel: ViewModel
    @State var width: CGFloat = .infinity

    init(viewModel: ViewModel = MainWindowViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        HSplitView {
            VStack {
                HeaderView()
                    .background(BlurView(material: .titlebar))
                VStack {
                    LogView()
                }
                .layoutPriority(1)
            }
            PacketView()
                .background(BlurView(material: .underPageBackground))
                .frame(maxWidth: viewModel.isSidebarVisible ? .infinity : 0)
        }
        .overlay(alignment: .center, content: {
            ErrorView()
        })
        .overlay(alignment: .bottom, content: {
            ToastContainerView()
        })
        .frame(minWidth: 800, minHeight: 480)
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
            .darkPreview(title: "Dark")
        MainWindow()
            .lightPreview(title: "Light")
    }
}
