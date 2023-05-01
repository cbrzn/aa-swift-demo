//
//  ContentView.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 26/3/23.
//

import SwiftUI
import PolywrapClient
import metamask_ios_sdk
import MetamaskProvider

struct ContentView: View {
    @ObservedObject var ethereum: Ethereum = MetaMaskSDK.shared.ethereum
    private let dapp = Dapp(name: "Polywrap dApp", url: "https://polywrap.io")
    @State private var metamaskProvider: MetamaskProvider? = nil

    var body: some View {
        VStack {
            Text("Account abstraction demo")
                .bold()
            if ethereum.selectedAddress != "" && metamaskProvider != nil {
                AccountAbstractionView(metamaskProvider: metamaskProvider!)
            } else {
                Button {
                    connect()
                } label: {
                    Text("Connect")
                }
            }
                      
        }.padding()
    }

    func connect() {
        metamaskProvider = MetamaskProvider(ethereum: ethereum, dapp: dapp)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
