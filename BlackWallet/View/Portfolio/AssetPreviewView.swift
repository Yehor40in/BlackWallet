//
//  AssetPreviewView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 08.02.24.
//

import SwiftUI
import WrappingStack

struct AssetPreviewView: View {
    
    var tags: [String] = ["Lorem", "Ipsum", "Dolor", "Sit", "Amet", "Eins", "Zwei", "Drei", "Sieben"]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("ether")
                        .resizable()
                        .scaledToFit()
                        .frame(width: Style.fifty_cgf(), height: Style.fifty_cgf())
                        .shadow(radius: 3, x: 3, y: 3)
                    VStack (alignment: .leading) {
                        Text("$2,234")
                            .font(.title2)
                            .bold()
                        HStack {
                            Image(systemName: "arrow.up")
                            Text("2.45%")
                                .bold()
                        }
                    }
                    .foregroundStyle(.white)
                    Spacer()
                }
                .foregroundColor(.init(UIColor.darkGray.cgColor))
                .padding()
                GradientLineChartView(isOverview: true)
                    .frame(height: 300)
                    .padding(.vertical)
                WrappingHStack(id: \.self, alignment: .leading, horizontalSpacing: Style.ten_cgf(), verticalSpacing: Style.ten_cgf()) {
                    
                    ForEach(tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .bold()
                            .padding()
                            .background(Style.primaryLinearGradientFillingVariantDark_1())
                            .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
                            .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())
                            .foregroundColor(.white)
                    }
                }
                .padding()
                VStack(alignment: .leading) {
                    Text("About Ethereum")
                        .bold()
                        .font(.title2)
                        .padding()
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                        .padding()
                        .font(.callout)
                }
                .background(Style.primaryLinearGradientFillingVariantDark_1())
                .foregroundColor(.white)
                .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
                .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())
                .padding()
                
                Spacer()
            }
            .navigationTitle("Ethereum")
        }
        .background(.black)
    }
}

struct AssetPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        AssetPreviewView()
    }
}
