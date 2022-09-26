//
//  LogViewEventHandler.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 18..
//

protocol LogViewEventHandling {
    func selectPackets(identifiers: [String])
}

struct LogViewEventHandler {
    private let appState: Observed<AppState>
    private let packetState: Observed<PacketState>
    private let selectPacketsUseCase: SelectPacketsUseCaseInterface

    init(appState: Observed<AppState>,
         packetState: Observed<PacketState>,
         selectPacketsUseCase: SelectPacketsUseCaseInterface) {
        self.appState = appState
        self.packetState = packetState
        self.selectPacketsUseCase = selectPacketsUseCase
    }
}

extension LogViewEventHandler: LogViewEventHandling {
    func selectPackets(identifiers: [String]) {
        print("Selecting: \(identifiers)")
        let packets = packetState.state.projects.filterPackets(filter: appState.state.filter).filter { packet in
            identifiers.contains(packet.id)
        }
        print("packets to select: \(identifiers)")
        selectPacketsUseCase.execute(packets: packets)
    }

}
