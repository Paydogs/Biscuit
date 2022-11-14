//
//  MockToastMessageViewModel.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 10..
//

class MockToastContainerViewModel: ToastContainerViewModelInterface {
    var messageList: [String] {
        ["Some message...",
         "A much longer message, which can be interesting",
         "A really really long message, where I hope we can introduce some line breaking. Would be nice. To be sure, lets have some more text"]
    }

}
