//
//  VerifyRecoveryPhraseView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 12.02.24.
//

import SwiftUI

struct VerifyRecoveryPhraseView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                Text("Step 3. Verify your private seed phrase")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                HStack (spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        TextField("1.", text: $modelData.providedMnemonic.word1)
                            .bold()
                        TextField("2.", text: $modelData.providedMnemonic.word2)
                            .bold()
                        TextField("3.", text: $modelData.providedMnemonic.word3)
                            .bold()
                        TextField("4.", text: $modelData.providedMnemonic.word4)
                            .bold()
                        TextField("5.", text: $modelData.providedMnemonic.word5)
                            .bold()
                        TextField("6.", text: $modelData.providedMnemonic.word6)
                            .bold()
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        TextField("7.", text: $modelData.providedMnemonic.word7)
                            .bold()
                        TextField("8.", text: $modelData.providedMnemonic.word8)
                            .bold()
                        TextField("9.", text: $modelData.providedMnemonic.word9)
                            .bold()
                        TextField("10.", text: $modelData.providedMnemonic.word10)
                            .bold()
                        TextField("11.", text: $modelData.providedMnemonic.word11)
                            .bold()
                        TextField("12.", text: $modelData.providedMnemonic.word12)
                            .bold()
                    }
                }
                .padding()
                .foregroundStyle(.white)
                .background(Style.primaryLinearGradientFillingVariantDark_1())
                .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
                .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())

                Spacer()
                Button(action: {
//                    if (modelData.mnemonicsEqual()) {
                        modelData.routes.append(Routes.homeView)
//                    }
                }, label: {
                    ClassicButtonView(content: .init(type: .primary, title: "Proceed"), background: Style.primaryLinearGradientFilling())
                })
            }
            .padding()
        }
        .navigationTitle("Setup recovery phrase")
    }
}

#Preview {
    VerifyRecoveryPhraseView()
        .environmentObject(ModelData())
}
