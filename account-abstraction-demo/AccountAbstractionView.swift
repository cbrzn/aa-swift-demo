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
    @State private var safeAddress = "0x61FfE691821291D02E9Ba5D33098ADcee71a3a17"
    @State private var saltNonce = ""
    @State private var numberToStore = 0
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
//            if !isDeployed {
//                TextField("Number to store", text: numberToStore)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//            }
            Button(action: {
                Task {
                    // Add your deploy safe action here
                    let result = await encodeFunctionWithClient()
                    print(result)
                }
            }) {
                Text("Encode")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            Button(action: {
                Task {
                    // Add your deploy safe action here
                    let result = await executeTransaction()
                    print(result)
                }
            }) {
                Text("Send transaction from client & plugin!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button(action: {
                Task {
                    // Add your deploy safe action here
                    let result = await getBalanceThroughClient()
                    print(result)
                }
            }) {
                Text("Get balance from metamask using client & only provider plugin")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button(action: {
                Task {
                    // Add your deploy safe action here
                    let result = await getBalanceDirectlyFromMetamask()
                    print(result)
                }
            }) {
                Text("Get balance from metamask directly")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button(action: {
                Task {
                    // Add your deploy safe action here
                    let result = await getUserBalancerThroughWrapper()
                    print(result)
                }
            }) {
                Text("Get balance through wrapper")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
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
        let userAddress = await metamaskProvider.address(ArgsAddress())
        let args = ArgsGetSafeAddress(userAddress)
        print("user address: \(userAddress)")
        let address = getSafeAddress(args, client)
        print(address)
        return address
    }
    
    func getBalanceDirectlyFromMetamask() async -> String {
        let client = getClient(metamaskProvider)
        let address = await metamaskProvider.address(ArgsAddress())
        let result = await metamaskProvider.request(args: ArgsRequest(method: "eth_getBalance", params: "[\"\(address)\",\"latest\"]"))
        print(result)
        return result
    }
    
    func getBalanceThroughClient() async -> String {
        let client = getClient(metamaskProvider)
        let address = await metamaskProvider.address(ArgsAddress())
        
        let args = ArgsGetBalanceProvider(address: address)
        let result = getBalanceThroughClientAndMetamask(args, client)
        print(result)
        return result
    }

    
    func getUserBalancerThroughWrapper() async -> String {
        let client = getClient(metamaskProvider)
        let userAddress = await metamaskProvider.address(ArgsAddress())

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
    
    func executeTransaction() async -> String {
        let client = getClient(metamaskProvider)
        let userAddress = await metamaskProvider.address(ArgsAddress())
//        let metaTransaction = [
//            "to": "0x56535D1162011E54aa2F6B003d02Db171c17e41e",
//            "value": "0",
//            "data": encodedFunction,
//            "operation": "0"
//        ]
//
//        let tx = Transaction(to: "0x56535D1162011E54aa2F6B003d02Db171c17e41e", from: userAddress, value: "0", data: "0x6057361d0000000000000000000000000000000000000000000000000000000000000004")
//        print(tx)
        
        
        struct CustomArgsRequest: Codable {
            var method = "eth_sendTransaction"
            var params: String
            public init(tx: [String: String]) {
                let jsonData = try! JSONEncoder().encode([tx])
                self.params = String(data: jsonData, encoding: .utf8)!
            }
        }
        
        let txData = [
            "to": "0x56535D1162011E54aa2F6B003d02Db171c17e41e",
            "from": userAddress,
            "value": "0",
            "data": "0x6057361d0000000000000000000000000000000000000000000000000000000000000007"
        ]
        let result = client.invoke(
            uri: ETHEREUM_PROVIDER_URI,
            method: "request",
            args: CustomArgsRequest(tx: txData),
            env: nil
        )
        
//        let executeTransaction = client.invoke(
//            uri: ETHEREUM_CORE_WRAPPER_URI,
//            method: "sendTransaction",
//            args: tx,
//            env: nil
//        )
        
        print(result)
        return result

 //        let estimateGasArgs = ArgsEstimateTransactionGas(
 //           to: metaTransaction["to"],
 //           value: metaTransaction["value"],
 //           data: metaTransaction["data"]
 //       )
 //       let gasLimit = estimateGas(estimateGasArgs, client)
//        let gasLimit = "350000"
//
//        let options = MetaTransactionOptions(isSponsored: true, gasLimit: gasLimit)
//        print("options: \(options)")
//        let relayTransactionArgs = ArgsRelayTransaction(transaction: metaTransaction, options: options)
//
//        let transactionRelayed = relayTransaction(relayTransactionArgs, client)
//        print("transaction relayed: \(transactionRelayed)")
//        return transactionRelayed
//        return "0x4c4883d08f10776182b734f6dedd4b53c428777d30826978bfef164d735bdd5a"
    }
}

//struct AccountAbstractionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountAbstractionView()
//    }
//}
