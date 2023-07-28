//
//  AccountAbstraction.swift
//  EthereumDemo
//
//  Created by Cesar Brazon on 25/7/23.
//

import SwiftUI
import MetamaskProviderPlugin
import metamask_ios_sdk
import PolywrapClient

struct AccountAbstractionView: View {
    var metamaskProvider: MetamaskProvider
    @State private var signerAddress = "0x61FfE691821291D02E9Ba5D33098ADcee71a3a17"
    @State private var safeAddress = ""
    @State private var saltNonce = ""
    @State private var numberToStore = 0
    @State private var isDeployed = false
    @State private var isLoading = false
    @State private var isExecuting = false

    var body: some View {
        VStack {
            Text("Connected with address: " + signerAddress.prefix(6) + "..." + signerAddress.suffix(6))
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
            .padding(.horizontal)

            Button(action: {
                Task {
                    isExecuting = true
                    defer { isExecuting = false }
                    // Add your deploy safe action here
                    do {
                        let result = try await executeDeploy()
                        print(result)
                    } catch {
                        print("error deploying: \(error)")
                    }
                }
            }) {
                if isExecuting {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.top)
                } else {
                    Text("Deploy safe")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)

        }
        .onAppear {
            Task {
//                safeAddress = await getAccountAddress()
            }
        }
    }
    
    
    func executeDeploy() async throws -> String {
        let client = try getClient(metamaskProvider)
//        let userAddress: String = await metamaskProvider.signerAddress(VoidCodable())
        let safeArgs = ArgsSafe("0x61FfE691821291D02E9Ba5D33098ADcee71a3a17", "0x7777773994")
        let result = try deploySafe(safeArgs, client)
        return result
//        return ""
    }
}

//struct AccountAbstractionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountAbstractionView()
//    }
//}
