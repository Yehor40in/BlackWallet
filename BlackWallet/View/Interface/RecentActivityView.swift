//
//  RecentActivityView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 06.02.24.
//

import SwiftUI

struct RecentActivityView: View {
    var transactions = [
        TransactionData(
            type: .credit,
            description: "to 0x71C7..976F",
            amount: "-14.65 $", symbol: "ether"),
        TransactionData(
            type: .credit,
            description: "to 0x71C7..976F",
            amount: "-5.37 $", symbol: "ether"),
        TransactionData(
            type: .debit,
            description: "from 0x71C7..976F",
            amount: "+4700 $", symbol: "usdc")
    ]
    
    var body: some View {
        VStack (alignment: .leading, spacing: Style.defaultStackSpacing()) {
            HStack {
                Text("Recent Activity")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {}) {
                    Image(systemName: "clock")
                }
                .padding()
            }
            .padding()
            VStack {
                ForEach(transactions) { trx in
                    TransactionView(transaction: trx)
                }
                .padding()
            }
            
        }
        .background(Style.primaryLinearGradientFillingVariantDark_1())
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
        .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())
    }
}

public struct TransactionData: Identifiable {
    public enum TransactionType {
        case debit
        case credit
    }
    
    public var id = UUID()
    var type: TransactionData.TransactionType
    var description: String
    var amount: String
    var symbol: String
}

struct TransactionView: View {
    var transaction: TransactionData
    var body: some View {
        HStack {
            HStack {
                Image(transaction.symbol)
                    .resizable()
                    .frame(width: Style.thirty_cgf(), height: Style.thirty_cgf())
                Text(transaction.description)
                    .font(.title3)
                    .bold()
                    .lineLimit(1)
            }
            Spacer()
            Text(transaction.amount).font(.title3).bold()
        }
    }
}

struct RecentActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RecentActivityView()
    }
}
