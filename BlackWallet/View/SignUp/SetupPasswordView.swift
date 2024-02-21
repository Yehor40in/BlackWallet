//
//  SetupPasswordView.swift
//  BlackWallet
//
//  Created by Yehor Sorokin on 17.02.24.
//

import SwiftUI

struct SetupPasswordView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    enum Field: Hashable {
        case password
        case repeatPassword
    }
    
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack (alignment: .leading ) {
                Text("Create a new wallet")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                Spacer()
                Text("Setup a secure password for recovey")
                    .foregroundStyle(.white)
                    .bold()
                SecureField("Enter your password here", text: $password)
                    .foregroundStyle(.white)
                    .focused($focusedField, equals: .password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 0.5)
                    )
                Text("Please verify your password")
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.top)
                SecureField("Please verify your password", text: $repeatPassword)
                    .focused($focusedField, equals: .repeatPassword)
                    .transition(.slide)
                    .foregroundStyle(.white)
                    .focused($focusedField, equals: .password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 0.5)
                    )
                Spacer()
                Button(action: {
                    if (passwordsMatch()) {
                        modelData.routes.append(Routes.createWallet(password))
                    }
                }, label: {
                    ClassicButtonView(content: .init(type: .primary, title: "Next"), background: Style.primaryLinearGradientFilling())
                })
            }
            .padding()
        }
        .onAppear {
            focusedField = .password
        }
    }
    
    private func passwordsMatch() -> Bool {
        if (password.isEmpty || repeatPassword.isEmpty) {
            return false
        }
        return password == repeatPassword
    }
}

#Preview {
    SetupPasswordView()
        .environmentObject(ModelData())
}
