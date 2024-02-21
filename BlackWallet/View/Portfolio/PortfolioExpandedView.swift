//
//  PortfolioExpandedView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 10.02.24.
//

import SwiftUI

struct PortfolioExpandedView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
            VStack {
                PortfolioOverviewView()
                    .padding()
                    .frame(minHeight: 610)
                
                AssetsView()
                    .padding(.horizontal)
            }
            .foregroundColor(.white)
            .navigationTitle("Portfolio")
        }
        .background(.black)
    }
}

struct PortfolioExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioExpandedView()
            .environmentObject(ModelData())
    }
}
