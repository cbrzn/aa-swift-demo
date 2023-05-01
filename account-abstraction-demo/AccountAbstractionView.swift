//
//  SafeDeployment.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 26/3/23.
//

import SwiftUI
import MetamaskProvider
import metamask_ios_sdk
import PolywrapClient
import HttpPlugin

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
            .padding(.horizontal)

            Button(action: {
                Task {
                    isExecuting = true
                    defer { isExecuting = false }
                    // Add your deploy safe action here
                    let result = await executeTransaction()
                    print(result)
                }
            }) {
                if isExecuting {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.top)
                } else {
                    
                    
                    Text("Send transaction through AA")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)

            Button(action: {
                Task {
                    isLoading = true
                    defer { isLoading = false }
                    // Add your deploy safe action here
                    let result = await getAccountAddress()
                    safeAddress = result.replacingOccurrences(of: "\"", with: "")
                }
            }) {
                if isLoading {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.top)
                } else {
                    Text("Get predicted safe address")
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
    
    
    func getAccountAddress() async -> String {
        let client = getClient(metamaskProvider)
        let userAddress: String = await metamaskProvider.signerAddress(ArgsAddress())
        let args = ArgsGetSafeAddress(userAddress, nil)
        let address = getSafeAddress(args, client)
        return address
    }
    
    func getBalanceDirectlyFromMetamask() async -> String {
        let client = getClient(metamaskProvider)
        let address = await metamaskProvider.signerAddress(ArgsAddress())
        let result = await metamaskProvider.request(args: ArgsRequest(method: "eth_getBalance", params: "[\"\(address)\",\"latest\"]"))
        print(result)
        return result
    }
    
    func getBalanceThroughClient() async -> String {
        let client = getClient(metamaskProvider)
        let address = await metamaskProvider.signerAddress(ArgsAddress())
        
        let args = ArgsGetBalanceProvider(address: address)
        let result = getBalanceThroughClientAndMetamask(args, client)
        print(result)
        return result
    }

    
    func getUserBalancerThroughWrapper() async -> String {
        let client = getClient(metamaskProvider)
        let userAddress = await metamaskProvider.signerAddress(ArgsAddress())

        let balance = getBalance(ArgsGetBalance(address: userAddress), client)
        print(balance)
        return balance
    }
    
    func encodeFunctionWithClient() async -> String {
        let client = getClient(metamaskProvider)
        let encodeFunctionArgs = ArgsEncodeFunction(
            method: "function store(uint256 num) public",
            args: ["4"]
        )
        let encodedFunction = encodeFunction(encodeFunctionArgs, client)
        return encodedFunction
        
    }
    
    func signTypedDataUI() async -> Void {
        let client = getClient(metamaskProvider)
        let args = ArgsSignTypedData()
        let r = signTypedData(args, client)
        print(r)
    }
    
    func executeTransaction() async -> String {
        let client = getClient(metamaskProvider)
        let userAddress = await metamaskProvider.signerAddress(ArgsAddress())
        
        let metaTransaction = [
            "to": "0x56535D1162011E54aa2F6B003d02Db171c17e41e",
            "value": "0",
            "data": "0x6057361d0000000000000000000000000000000000000000000000000000000000000015",
            "operation": "0"
        ]

        let gasLimit = "350000"

        let options = MetaTransactionOptions(isSponsored: true, gasLimit: gasLimit)
        print("options: \(options)")
        let relayTransactionArgs = ArgsRelayTransaction(transaction: metaTransaction, options: options)

        let transactionRelayed = relayTransaction(relayTransactionArgs, client)
        print("transaction relayed: \(transactionRelayed)")
        return transactionRelayed
    }
}

//struct AccountAbstractionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountAbstractionView()
//    }
//}
