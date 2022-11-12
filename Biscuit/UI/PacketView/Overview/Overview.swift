//
//  Overview.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 10. 02..
//

import SwiftUI

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }
    }
}

struct Overview<ViewModel: OverviewViewModelInterface>: View {
    @StateObject var viewModel: ViewModel

    init(viewModel: ViewModel = OverviewViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            AttributedTextView(attributedText: viewModel.packetBody)
                .background(Colors.Overview.background)
            Divider()
            HStack {
                SmallActionButton(data: copyBodyToClipboardButtonData,
                                  event: .init(action: {  viewModel.copyBodyToClipboard(packet: viewModel.selectedPacket) }))
                Spacer()
            }
        }
    }
}

private extension Overview {
    var copyBodyToClipboardButtonData: SmallActionButton.Data {
        return SmallActionButton.Data(icon: "doc.on.clipboard.fill",
                                      help: Localized.PacketView.Button.copyToPasteboard)
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview(viewModel: MockOverviewViewModel())
            .darkPreview(title: "Dark")
        Overview(viewModel: MockOverviewViewModel())
            .lightPreview(title: "Light")
    }
}
