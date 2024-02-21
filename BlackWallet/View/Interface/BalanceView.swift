//
//  BalanceView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 06.02.24.
//

import SwiftUI

struct BalanceView: View {
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: Style.zero_cgf()) {
                Text("$")
                    .font(.title2)
                    .bold()
                Text("15,5312")
                    .font(.title2)
                    .bold()
                Text(".")
                    .foregroundColor(Color.gray)
                    .font(.title2)
                    .bold()
                Text("23")
                    .foregroundColor(Color.gray)
                    .font(.title2)
                    .bold()
            }
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
