//
//  ContentView.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 26/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isConnected = false

    var body: some View {
        VStack {
            Text("Account abstraction demo")
                .bold()
            if isConnected {
                SafeDeploymentView()
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
        isConnected = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
