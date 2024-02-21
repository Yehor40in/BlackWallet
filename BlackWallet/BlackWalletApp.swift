//
//  BlackWalletApp.swift
//  BlackWallet
//
//  Created by Yehor Sorokin on 13.02.24.
//

import SwiftUI

@main
struct BlackWalletApp: App {
    
    let modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(modelData)
        }
    }
}
