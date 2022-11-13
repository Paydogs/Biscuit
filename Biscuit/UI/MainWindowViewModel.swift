//
//  MainWindowViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 13..
//

import Factory
import Combine

protocol MainWindowViewModelInterface: ObservableObject {
    var isSidebarVisible: Bool  { get }
}

class MainWindowViewModel: MainWindowViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    private var subscriptions: Set<AnyCancellable> = []

    @Published var isSidebarVisible: Bool = true

    init() {
        appStore.observed.$state.map(\.isSidebarOpen)
            .sink { [weak self] (isSidebarOpen: Bool) in
                self?.isSidebarVisible = isSidebarOpen
            }
            .store(in: &subscriptions)
    }
}
