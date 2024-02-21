//
//  SetupRecoveryPhraseView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 12.02.24.
//

import SwiftUI
import Foundation

struct SetupRecoveryPhraseView: View {
    
    var password: String
    
    @EnvironmentObject var modelData: ModelData
    @State var phrase: Array<String> = []
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                Text("Step 2. Please save your private seed phrase")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                HStack (spacing: 20) {
                    if (phrase.count > 0) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("1. " + phrase[0] )
                                .bold()
                            Text("2. " + phrase[1])
                                .bold()
                            Text("3. " + phrase[2])
                                .bold()
                            Text("4. " + phrase[3])
                                .bold()
                            Text("5. " + phrase[4])
                                .bold()
                            Text("6. " + phrase[5])
                                .bold()
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            Text("7. " + phrase[6])
                                .bold()
                            Text("8. " + phrase[7])
                                .bold()
                            Text("9. " + phrase[8])
                                .bold()
                            Text("10. " + phrase[9])
                                .bold()
                            Text("11. " + phrase[10])
                                .bold()
                            Text("12. " + phrase[11])
                                .bold()
                        }
                    }
                }
                .padding()
                .foregroundStyle(.white)
                .background(Style.primaryLinearGradientFillingVariantDark_1())
                .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
                .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())
                Text("⚠️ For your eyes only")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                NavigationLink(value: Routes.VerifyMnemonics) {
                    ClassicButtonView(content: .init(type: .primary, title: "I have saved my secret phrase"), background: Style.primaryLinearGradientFilling())
                }
                ClassicButtonView(content: .init(type: .primary, title: "Help"), background: Style.primaryLinearGradientFillingVariantDark_1())
            }
            .padding()
        }
        .navigationTitle("Setup recovery phrase")
        .onAppear {
            let (mnemonic, keystore) = modelData.web3coordinator.createWallet(password: password)
            
            modelData.w3wallet.keyStore = keystore
            modelData.w3wallet.address = keystore!.addresses!.first!.address
            modelData.w3wallet.portfolio = []
            modelData.w3wallet.name = "\(UUID())"
//            modelData.w3wallet.portfolio = modelData.web3coordinator.fetchProtfolio(for: address)
            modelData.expectedMnemonic = Mnemonic(from: mnemonic)
            phrase = mnemonic.split(separator: " ").map{ String($0) }
        }
    }
}
//
//#Preview {
//    SetupRecoveryPhraseView()
//        .environmentObject(ModelData())
//}
