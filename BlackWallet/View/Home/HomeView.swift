//
//  HomeView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 24.10.23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State var showsSheet = false
    @State var showsWidget = true
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center, spacing: Style.twenty_cgf()) {
                HStack {
                    AccountActionsButtonSetView(showsSheet: $showsSheet).padding([.top, .horizontal])
                    Spacer()
                }
                
                NavigationLink(value: Routes.portfolio) {
                    HStack {
                        VStack (alignment: .leading) {
                            BalanceView()
                            HStack {
                                Image(systemName: "arrow.up")
                                Text("0.57 %")
                                    .bold()
                            }
                        }
                        .padding()
                        Spacer()
                        GradientLineChartView(isOverview: true)
                            .frame(width: 120, height: 70)
                            .padding()
                    }
                    .padding()
                    .background(Style.primaryLinearGradientFillingVariantDark_1())
                    .foregroundStyle(.white)
                    .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
                    .padding(.horizontal)
                }
                RecentActivityView().padding(.horizontal)
                ClassicButtonView(content: .init(type: .customize, title: "Customize"), background: Style.primaryLinearGradientFillingVariantDark_1())
                    .frame(width: 120)
                
                Spacer()
            }
            .sheet(isPresented: $showsSheet) {
                QRCodeView()
            }
            .navigationBarColor(.white)
        }
        
        .navigationTitle(modelData.w3wallet.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    modelData.routes.append(Routes.settings)
                }, label: {
                    Image(systemName: "gearshape")
                })
            }
        }
        .foregroundStyle(.white)
        .background(.black)
    }
}

extension View {
    func navigationBarColor(_ color: UIColor) -> some View {
        self.modifier(NavigationBarColorModifier(color: color))
    }
}

struct NavigationBarColorModifier: ViewModifier {
    var color: UIColor

    func body(content: Content) -> some View {
        content
            .onAppear {
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.configureWithOpaqueBackground()
                coloredAppearance.titleTextAttributes = [.foregroundColor: color]
                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: color]
                coloredAppearance.backgroundColor = UIColor.black

                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().compactAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
    }
}

#Preview {
    HomeView()
        .environmentObject(ModelData())
}
