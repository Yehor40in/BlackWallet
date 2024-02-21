//
//  PortfolioOverviewView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 06.02.24.
//

import SwiftUI

struct PortfolioOverviewView: View {
    
    @State var portfolio: [TokenData] = [.init(name: "Ethereum", symbol: "ether")]
    
    var body: some View {
        VStack (alignment: .center, spacing: Style.defaultStackSpacing()) {
            VStack (spacing: Style.zero_cgf()) {
                HStack {
                    Text("Overview").font(.title).bold()
                    Spacer()
                    Image(systemName: "case")
                    .padding()
                }
                HStack {
                    Image(systemName: "arrow.up")
                    Text("0.57 %")
                        .bold()
                    Spacer()
                }
            }
            .padding()
            
            if (portfolio.isEmpty) {
                PortfolioEmptyView()
            } else {
                PieChartView(
                    values: [1300, 500, 300],
                    names: ["ETH", "USDC", "Other"],
                    formatter: {value in String(format: "$%.2f", value)},
                    colors: [Color.indigo, Color.cyan, Color.blue])
            }
        }
        .background(.black)
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
    }
}

struct PortfolioEmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Nothing to show here.. yet!")
                .font(.subheadline)
            Button(action: {}, label: {
                Text("Discover how to buy your fist crypto")
                    .bold()
                    .underline()
            })
        }
        .padding()
    }
}

struct PortfolioOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioOverviewView()
    }
}
