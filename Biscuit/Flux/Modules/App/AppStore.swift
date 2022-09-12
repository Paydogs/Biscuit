//
//  AppStore.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 08. 11..
//

class AppStore: BaseStore<AppState> {
    override func handleAction(action: FluxAction) {
        guard let action = action as? AppActions else { return }
        print("[AppStore] AppStore is handling action")
        switch action {
            case .didConnectClient(let client):
                handleDidConnectClient(client: client)
            case .didDisconnectClient(let client):
                handleDidDisconnectClient(client: client)
            case .didReceivedErrors(let error):
                handleDidReceivedErrors(errors: error)
            case .didSelectProject(let project):
                handleDidSelectProject(project: project)
            case .didSelectDevice(let device):
                handleDidSelectDevice(device: device)
        }
    }
}

private extension AppStore {
    func handleDidConnectClient(client: Client) {
        update { state in
            print("[APPSTORE MANIP] Client connected: \(client)")
            state.connectedClients.append(client)
        }
    }

    func handleDidDisconnectClient(client: Client) {
        update { state in
            print("[APPSTORE MANIP] Client disconnected: \(client)")
            state.connectedClients.removeAll(where: { (connectedClient: Client) in connectedClient == client })
        }
    }

    func handleDidReceivedErrors(errors: [AppError]) {
        update { state in
            print("[APPSTORE MANIP] Error: \(errors)")
            state.errors.append(contentsOf: errors)
        }
    }

    func handleDidSelectProject(project: Project?) {
        update { state in
            print("[APPSTORE MANIP] project selected: \(project)")
            state.selectedProject = project
            state.selectedDevice = project?.devices.first
        }
    }

    func handleDidSelectDevice(device: Device?) {
        update { state in
            print("[APPSTORE MANIP] device selected: \(device)")
            state.selectedDevice = device
        }
    }
}
