//
//  MainWindow.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 23..
//

import SwiftUI

struct MainWindow: View {
//    @State text: Text
    var body: some View {
        HStack {
            ProcessContainer()
            VStack {
                Button("Test", action: {
                    NSLog("Tapped")
                })
                .frame(minWidth: 100, maxHeight: 44)

                LogContainer()
            }
        }
        .frame(minWidth: 640, minHeight: 480)
    }
}

struct ProcessContainer: View {
    var body: some View {
        Text("Process Container")
            .padding()
    }
}

struct LogContainer: View {
    var body: some View {
        Text("Test")
    }
}

struct MainWindow_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
    }
}
