//
//  MainWindow.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI
import Factory
import Combine

struct MainWindow: View {
    @ObservedObject var appState: Observed<AppState>
    @ObservedObject var packetState: Observed<PacketState>

    var body: some View {
        VStack {
            HeaderComponent(data: HeaderComponent.Data(projectList: HeaderComponentUIMapper.getProjectNameList(list: packetState.state.projects),
                                                       deviceList: []),
                            event: HeaderComponent.Event(projectSelectionChanged: { index in print("project index selected: \(index)") },
                                                         deviceSelectionChanged: { index in print("device index selected: \(index)") }))
            HStack {
                HStack {
                    ProcessContainer()
                        .background(Colors.Background.panelBackground)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                VStack {
                    LogContainer(data: LogContainer.Data(currentValue: packetState.state.projects.count))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .frame(minWidth: 640, minHeight: 480)
        }
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow(appState: Observed<AppState>(state: AppState.defaultValue()),
                   packetState: Observed<PacketState>(state: PacketState.defaultValue()))
    }
}
