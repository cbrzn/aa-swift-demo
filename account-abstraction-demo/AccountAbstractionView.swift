//
//  SafeDeployment.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 26/3/23.
//

import SwiftUI

struct AccountAbstractionView: View {
    @State private var signerAddress = "0x61FfE691821291D02E9Ba5D33098ADcee71a3a17"
    @State private var safeAddress = "0x61FfE691821291D02E9Ba5D33098ADcee71a3a17"
    @State private var saltNonce = ""
    @State private var isDeployed = false

    var body: some View {
        VStack {
            Text("Owner ID: " + signerAddress.prefix(6) + "..." + signerAddress.suffix(6))
            HStack {
                Text("Safe Address: " + safeAddress.prefix(6) + "..." + safeAddress.suffix(6))
                Button {
                    if let url = URL(string: "https://goerli.etherscan.io/address/" + safeAddress), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Image(systemName: "link")
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
            if !isDeployed {
                TextField("Salt Nonce", text: $saltNonce)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            Button(action: {
                // Add your deploy safe action here
            }) {
                Text(isDeployed ? "Execute transaction" : "Deploy safe and execute transaction")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
    }
}

struct AccountAbstractionView_Previews: PreviewProvider {
    static var previews: some View {
        AccountAbstractionView()
    }
}
