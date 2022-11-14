//
//  ToastContainerViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 10..
//

import Factory
import Combine

protocol ToastContainerViewModelInterface: ObservableObject {
    var messageList: [String]  { get }
}

class ToastContainerViewModel: ToastContainerViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    private var subscriptions: Set<AnyCancellable> = []

    @Published var messageList: [String] = []

    init() {
        appStore.observed.$state.map(\.messages)
            .sink { [weak self] (messageList: [String]) in
                self?.messageList = messageList
            }
            .store(in: &subscriptions)
    }
}
