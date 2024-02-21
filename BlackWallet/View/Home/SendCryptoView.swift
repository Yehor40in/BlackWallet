//
//  SendCryptoView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 08.02.24.
//

import SwiftUI

struct SendCryptoView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack (alignment: .leading, spacing: Style.zero_cgf()){
            Text("You are sending")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            VStack (alignment: .leading) {
                HStack {
                    Image("ether")
                        .resizable()
                        .scaledToFit()
                        .frame(width: Style.fifty_cgf(), height: Style.fifty_cgf())
                    Text("ETH")
                        .font(.title)
                        .bold()
                    Spacer()
                    Text("0.0234")
                        .font(.title)
                        .bold()
                }
                .padding()
                .foregroundColor(.white)
                .background(Style.primaryLinearGradientFillingVariantDark_1())
            }
            .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
            .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())
            .padding([.horizontal, .bottom])
            
            Text("To the address")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            VStack (alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: Style.twenty_cgf(), height: Style.twenty_cgf())
                        .padding(.leading)
                        .foregroundColor(.white)
                    TextField("Enter the receoient's ERC 20 address", text: $modelData.sendToAddressBinding)
                        .padding()
                }
                .padding()
            }
            .background(Style.primaryLinearGradientFillingVariantDark_1())
            .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
            .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())
            .padding([.horizontal, .bottom])
            
            HStack {
                Spacer()
                ClassicButtonView(content: .init(type: .primary, title: "Preview Transaction"), background: Style.primaryLinearGradientFillingVariantDark_1())
                Spacer()
            }
            .padding()
            Spacer()
            
        }
        .foregroundColor(.black)
    }
}

struct SendCryptoView_Previews: PreviewProvider {
    static var previews: some View {
        SendCryptoView()
            .environmentObject(ModelData())
    }
}
