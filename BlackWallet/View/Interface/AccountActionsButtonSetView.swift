//
//  ProfileView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 28.10.23.
//

import SwiftUI


struct AccountActionsButtonSetView: View {
    
    @Binding var showsSheet: Bool
    
    var buttons = [
        ButtonContent(type: .topUp, title: "Add", imageName: "banknote.fill"),
        ButtonContent(type: .send, title: "Send", imageName: "arrowshape.turn.up.right.circle.fill"),
        ButtonContent(type: .QRCode, title: "Code", imageName: "qrcode"),
        ButtonContent(type: .info, title: "More", imageName: "info.bubble")
    ]
    
    var body: some View {
        HStack {
            ForEach(buttons) { button in
                Button(action: {
                    if (button.type == .QRCode) {
                        showsSheet.toggle()
                    }
                }) {
                    if (button.type == .send) {
                        NavigationLink(value: Routes.sendCrypto) {
                            ClassicButtonView(content: button, background: Style.primaryLinearGradientFillingVariantDark_1())
                        }
                    } else {
                        ClassicButtonView(content: button, background: Style.primaryLinearGradientFillingVariantDark_1())
                    }
                }
            }
        }
    }
    
    
}

struct AccountActionsButtonSetView_Previews: PreviewProvider {
    static var previews: some View {
        AccountActionsButtonSetView(showsSheet: .constant(false))
    }
}
