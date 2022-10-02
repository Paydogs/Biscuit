//
//  BlurView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

struct BlurView: NSViewRepresentable {
    let material: NSVisualEffectView.Material

    func makeNSView(context: Context) -> some NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView(material: .headerView)
    }
}
