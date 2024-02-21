//
//  QRCodeView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 06.02.24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            Text("Tap to copy your address 👇")
                .font(.callout)
                .bold()
                .padding()
            Text("\(modelData.w3wallet.address[0..<5])...\(modelData.w3wallet.address[38...41])")
                .underline()
                .font(.callout)
                .bold()
                .padding(.bottom)
            Image(uiImage: generateQRCode(from: modelData.w3wallet.address))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
                .background(.white)
                .mask(RoundedRectangle(cornerRadius: 25))
                .shadow(radius: Style.twenty_cgf())
            ClassicButtonView(content: .init(type: .QRCode, title: "Scan QR Code"), background: Style.primaryLinearGradientFillingVariantDark_1())
                .padding(.vertical)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .padding()
        .background(Style.primaryLinearGradientFilling())
    }
        
    
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRCodeView()
        .environmentObject(ModelData())
}
