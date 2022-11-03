//
//  MainWindowController.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 04..
//

import Factory
import SwiftUI

class MainWindowController {
    let headerViewController: HeaderViewController
    let logViewController: LogViewController
    let packetViewController: PacketViewController

    init(headerViewController: HeaderViewController,
         logViewController: LogViewController,
         packetViewController: PacketViewController) {
        self.headerViewController = headerViewController
        self.logViewController = logViewController
        self.packetViewController = packetViewController
    }
}
