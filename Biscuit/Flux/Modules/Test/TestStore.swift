//
//  TestStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 13..
//

class TestStore: BaseStore<TestState> {
    override func handleAction(action: FluxAction) {
        guard let action = action as? TestActions else { return }
        print("[TestStore] TestStore is handling action")
        switch action {
            case .modifyValue(let amount):
                handleAmountChange(amount: amount)
        }
    }
}

private extension TestStore {
    func handleAmountChange(amount: Int) {
        update { state in
            state.currentValue = state.currentValue + amount
        }
    }
}
