//
//  AssetsView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 13.02.24.
//

import SwiftUI

struct AssetsView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        HStack (spacing: 0) {
            Text("Crypto")
                .font(.title)
                .bold()
                .padding(.leading)
            Text("NFTs")
                .font(.title)
                .bold()
                .padding(.leading)
                .foregroundColor(.init(UIColor.lightGray.cgColor))
            Spacer()
        }
        VStack {
            ForEach(modelData.wallets.first!.portfolio) { asset in
                NavigationLink(value: Routes.assetOverview) {
                    HStack {
                        Image(asset.symbol)
                            .resizable()
                            .frame(width: Style.fifty_cgf(), height: Style.fifty_cgf())
                            .shadow(radius: 3, x: 3, y: 3)
                        Text(asset.name)
                            .bold()
                            .font(.title2)
                        Spacer()
                        Text("$2,123")
                            .bold()
                            .font(.title2)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    AssetsView()
        .environmentObject(ModelData())
}
