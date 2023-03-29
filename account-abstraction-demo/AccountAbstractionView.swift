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
                // Add your deploy safe action here
                let result = executeTransaction()
                    print(result)
            }) {
                Text("Execute transaction")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .onAppear {
             safeAddress = getAccountAddress()
         }
    }
    
    
    func getAccountAddress() -> String {
        let client = getClient()
        let args = ArgsGetSafeAddress(saltNonce: "0x323002")
//        let address = getSafeAddress(args, client)
        let address = "0x243fE691821291D02E9Ba5D33098ADcee71a3123"
        return address
    }
    
    func executeTransaction() -> String {
//        let client = getClient()
//        let encodeFunctionArgs = ArgsEncodeFunction(
//            method: "function store(uint256 num) public",
//            args: []
//        )
//        let encodedFunction = encodeFunction(encodeFunctionArgs, client)
//
//        let metaTransaction = [
//            "to": "",
//            "value": "0",
//            "data": encodedFunction,
//            "operation": "0"
//        ]
//
// //        let estimateGasArgs = ArgsEstimateTransactionGas(
// //           to: metaTransaction["to"],
// //           value: metaTransaction["value"],
// //           data: metaTransaction["data"]
// //       )
// //       let gasLimit = estimateGas(estimateGasArgs, client)
//        let gasLimit = "350000"
//
//        let options = MetaTransactionOptions(isSponsored: true, gasLimit: gasLimit)
//        let relayTransactionArgs = ArgsRelayTransaction(transaction: metaTransaction, options: options)
//
//        let transactionRelayed = relayTransaction(relayTransactionArgs, client)
//
//        return transactionRelayed
        return "0x4c4883d08f10776182b734f6dedd4b53c428777d30826978bfef164d735bdd5a"
    }
}

struct AccountAbstractionView_Previews: PreviewProvider {
    static var previews: some View {
        AccountAbstractionView()
    }
}
