//
//  AboutView.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 11. 27..
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(ImageName.biscuitLarge)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            VStack(alignment: .leading) {
                Text(BundleUtils().bundleValue(for: .appName))
                    .font(.system(size: 35))
                Text(Localized.AboutView.version(BundleUtils().bundleValue(for: .version)))
                Text(BundleUtils().bundleValue(for: .copyright))
                    .font(.body)
                    .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                Text(Localized.AboutView.date)
                    .font(.body)
            }
            Spacer()
        }
        .frame(width: 550, height: 200)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
