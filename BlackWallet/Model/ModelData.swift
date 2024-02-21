//
//  ModelData.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 06.02.24.
//

import Foundation
import SwiftUI
import Web3Core
import web3swift


final class ModelData: ObservableObject {
    
    let web3coordinator = Web3Coordinator.shared
    
    var expectedMnemonic: Mnemonic = .emptyMnemonic
    @Published var providedMnemonic: Mnemonic = .emptyMnemonic
    
    @Published var w3wallet: Wallet = .dummy
    @Published var routes: Array<Routes> = []
    @Published var wallets: Array<Wallet> = [.dummy]
    @Published var hidesSmallBalances: Bool = false
    @Published var sendToAddressBinding: String = ""
    
    init() {
        if (web3coordinator.walletExists()) {
            fetchWallet()
            routes.append(Routes.homeView)
        }
    }
    
    
    func mnemonicsEqual() -> Bool {
        if (expectedMnemonic == .emptyMnemonic || providedMnemonic == .emptyMnemonic) {
            return false
        }
        return expectedMnemonic == providedMnemonic
    }
    
    func fetchWallet() {
        let ks = web3coordinator.importWallet()
        w3wallet.keyStore = ks
        w3wallet.address = ks.addresses!.first!.address
        w3wallet.portfolio = []
        w3wallet.name = ks.rootPrefix
//        modelData.w3wallet.portfolio = web3coordinator.fetchProtfolio(for: address)
    }
    
}

struct Wallet {
    static var dummy = Wallet(name: "Wallet 1", address: "0x207E804758e28F2b3fD6E4219671B327100b82f8")
    
    var name: String
    var iCloudBackedUp: Bool = false
    var address: String
    var keyStore: BIP32Keystore?
    var portfolio: [TokenData] = [.init(name: "ETH", symbol: "ether"), .init(name: "USDC", symbol: "usdc")]
}


struct TokenData: Identifiable {
    var id = UUID()
    var name: String
    var symbol: String
}
