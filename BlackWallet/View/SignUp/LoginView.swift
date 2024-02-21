//
//  LiginView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 12.02.24.
//

import SwiftUI
import Foundation

public enum Routes: Hashable {
    case homeView
    case setupPassword
    case createWallet(String)
    case importWallet
    case VerifyMnemonics
    case sendCrypto
    case portfolio
    case info
    case assetOverview
    case settings
    case appearanceSettings
    case currencySettings
    case recoverySettings
    case icloudSettings
}

struct LoginView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack(path: $modelData.routes) {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(value: Routes.setupPassword) {
                        ClassicButtonView(content: .init(type: .primary, title: "Create new wallet"), background: Style.primaryLinearGradientFilling())
                    }
                    NavigationLink(value: Routes.importWallet) {
                        ClassicButtonView(content: .init(type: .primary, title: "I already have a wallet"), background: Style.primaryLinearGradientFillingVariantDark_1())
                    }
                }
                .padding()
            }
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .sendCrypto:
                    SendCryptoView()
                case .info:
                    AssetPreviewView()
                case .portfolio:
                    PortfolioExpandedView()
                case .assetOverview:
                    AssetPreviewView()
                case .appearanceSettings:
                    Text("Hello World")
                case .currencySettings:
                    Text("Hello World")
                case .recoverySettings:
                    Text("Hello world")
                case .icloudSettings:
                    Text("Hello world")
                case .settings:
                    SettingsView()
                case .createWallet(let p):
                    SetupRecoveryPhraseView(password: p)
                case .importWallet:
                    Text("Hello world")
                case .VerifyMnemonics:
                    VerifyRecoveryPhraseView()
                case .homeView:
                    HomeView()
                case .setupPassword:
                    SetupPasswordView()
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(ModelData())
}
