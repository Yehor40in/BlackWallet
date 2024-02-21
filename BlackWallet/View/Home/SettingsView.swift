//
//  SettingsView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 11.02.24.
//

import SwiftUI

struct SettingContent: Identifiable {
    var id = UUID()
    var description: String
    var image: Image
    var switchable: Bool
}

struct SettingsView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("App settings")) {
                    NavigationLink(value: Routes.appearanceSettings) {
                        SettingRow(content: .init(description: "Appearance", image: Image(systemName: "moon.circle"), switchable: false))
                    }
                    NavigationLink(value: Routes.currencySettings) {
                        SettingRow(content: .init(description: "Preffered currency", image: Image(systemName: "dollarsign"), switchable: false))
                    }
                    SettingRow(content: .init(description: "Hide small balances", image: Image(systemName: "chart.bar.doc.horizontal"), switchable: true))
                }

                Section(header: Text("Security")) {
                    NavigationLink(value: Routes.recoverySettings) {
                        SettingRow(content: .init(description: "Recovery phrase", image: Image(systemName: "lock.open.rotation"), switchable: false))
                    }
                    NavigationLink(value: Routes.icloudSettings) {
                        SettingRow(content: .init(description: "iCloud backup", image: Image(systemName: "lock.icloud.fill"), switchable: false))
                    }
                    
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingRow: View {
    @EnvironmentObject var modelData: ModelData
    
    var content: SettingContent
    
    var body: some View {
        HStack {
            content.image
            Text(content.description)
            if (content.switchable) {
                Spacer()
                Toggle("", isOn: $modelData.hidesSmallBalances)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ModelData())
    }
}
