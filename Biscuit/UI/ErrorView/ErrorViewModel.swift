//
//  ErrorViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 09..
//

import Foundation
import AppKit
import Factory
import Combine
import SwiftUI

protocol ErrorViewModelInterface: ObservableObject {
    var errorList: [String]  { get }
}

class ErrorViewModel: ErrorViewModelInterface {
    @Injected(BiscuitContainer.appStore) private var appStore
    private var subscriptions: Set<AnyCancellable> = []

    @Published var errorList: [String] = []

    init() {
        appStore.observed.$state.map(\.errors)
            .sink { [weak self] (errors: [AppError]) in
                for error in errors {
                    self?.errorList.append(error.localizedMessage())
                }
            }
            .store(in: &subscriptions)
    }
}
