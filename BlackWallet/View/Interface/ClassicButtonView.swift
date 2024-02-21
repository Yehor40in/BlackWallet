//
//  ClassicButtonView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 10.02.24.
//

import SwiftUI


struct ClassicButtonView: View {
    
    enum ClassicButtonType {
        case primary
        case topUp
        case send
        case QRCode
        case info
        case customize
    }
    
    var content: ButtonContent
    var background: LinearGradient
    
    var body: some View {
        VStack {
            if let image = content.imageName {
                Image(systemName: image)
            }
            Text(content.title).bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .background(background)
        .mask(RoundedRectangle(cornerRadius: Style.twenty_cgf()))
        .shadow(radius: Style.ten_cgf(), x: Style.ten_cgf(), y: Style.ten_cgf())
    }
}

public struct ButtonContent: Identifiable {
    var type: ClassicButtonView.ClassicButtonType
    var title: String
    var imageName: String?
    public var id = UUID()
}

struct ClassicButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicButtonView(content: .init(type: .QRCode, title: "QR code", imageName: "qrcode"), background: Style.primaryLinearGradientFilling())
    }
}
