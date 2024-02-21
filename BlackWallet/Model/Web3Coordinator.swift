//
//  Web3Coordinator.swift
//  BlackWallet
//
//  Created by Yehor Sorokin on 13.02.24.
//

import Foundation
import Web3Core
import web3swift
import BigInt


final class Web3Coordinator {
    static var shared = Web3Coordinator()
    
    let userDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let web3 = Web3(provider: Web3HttpProvider(url: URL(string: "https://goerli.infura.io/v3/7dceffcc53cd44758cade607c3bf91da")!, network: .Goerli))
    
    /// TODO improve this shit
    func walletExists() -> Bool {
        guard let ks = keystoreManagerFromDirectory() else { return false }
        guard let w = fetchWallet(using: ks) else { return false }
        return true
    }
    
    
    func createWallet(password: String) -> (String, BIP32Keystore?) {
        do {
            let mnemonic = try! BIP39.generateMnemonics(bitsOfEntropy: 128)!
            let keystore = try! BIP32Keystore(mnemonics: mnemonic, password: password, mnemonicsPassword: "")
            let keydata = try JSONEncoder().encode(keystore?.keystoreParams)
            
            guard persistKeysore(keydata: keydata) == true else {
                fatalError("\n\n\nCould not persist keystore createWallet(password: String)\n\n\n")
            }
            return (mnemonic, keystore)
        } catch {
            fatalError("\n\n\nCould not create wallet createWallet(password: String)\n\n\n")
        }
    }
    
    
    func importWallet() -> BIP32Keystore {
        guard let keystoreManager = keystoreManagerFromDirectory() else {
            fatalError("\n\n\nCould not init keystoreManager importWallet(address: EthereumAddress, password: String, mnemonic: String)\n\n\n")
        }
        guard let ks = fetchWallet(using: keystoreManager) else {
            fatalError("\n\n\nCould not fetch wallet importWallet(address: EthereumAddress, password: String, mnemonic: String)\n\n\n")
        }
        return ks
    }
    
    
    private func fetchWallet(using keystoreManager: KeystoreManager) -> BIP32Keystore? {
        guard let a = keystoreManager.addresses, let f = a.first else { return nil }
        return keystoreManager.walletForAddress(f) as? BIP32Keystore
    }
    
    
    private func keystoreManagerFromDirectory() -> KeystoreManager? {
        return KeystoreManager.managerForPath(userDir.appending(component: "keystore").path(), scanForHDwallets: true)
    }
    
    
    private func persistKeysore(keydata: Data) -> Bool {
        return FileManager.default.createFile(atPath: userDir.appending(component: "keystore/key.json").path(), contents: keydata, attributes: nil)
        
    }
    
    func walletAddress(for ks: BIP32Keystore) -> EthereumAddress {
        guard let address = ks.addresses?.first else {
            fatalError("\n\n\nCould not retrieve address from storage walletAddress(for ks: BIP32Keystore)\n\n\n")
        }
        return address
    }
    
    func sendEther(amount value: BigUInt, from address: EthereumAddress) async throws -> TransactionSendingResult {
        var transaction: CodableTransaction = .emptyTransaction
        transaction.from = address
        transaction.value = value
//        transaction.gasLimitPolicy = .manual(78423)
//        transaction.gasPricePolicy = .manual(20000000000)
        guard let status = try? await web3.eth.send(transaction) else {
            throw Web3Error.nodeError(desc: "\n\n\nCould not send ETH sendEther(amount value: BigUInt, from address: EthereumAddress)\n\n\n")
        }
        return status
    }
    
    
    func readContract(at address: EthereumAddress) async throws -> [String: Any] {
        let contract = getContract(at: address)
        let readOp = contract.createReadOperation("name")!
        readOp.transaction.from = EthereumAddress("0xe22b8979739D724343bd002F9f432F5990879901")
        let response = try await readOp.callContractMethod()
        return response
    }

    // [!!] Fix required
    private func getContract(at address: EthereumAddress) -> Web3.Contract {
        web3.contract(Web3.Utils.erc20ABI, at: address)! //TODO: Nil check required, might throw
    }
    
}
