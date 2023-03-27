//
//  ContentView.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 26/3/23.
//

import SwiftUI
import PolywrapClient
import HttpPlugin

struct ContentView: View {
    @State private var isConnected = false

    var body: some View {
        VStack {
            Text("Account abstraction demo")
                .bold()
            if isConnected {
                AccountAbstractionView()
            } else {
                Button {
                    invoke()
                } label: {
                    Text("Connect")
                }
            }
                      
        }.padding()
    }

    func connect() {
        isConnected = true
    }
    
    func invoke() {
        let builder = ConfigBuilder()
        let httpResolverUri = Uri("wrap://ens/http-resolver.polywrap.eth")!
        let plugin = HttpUriResolverPlugin()
        builder.addPlugin(uri: httpResolverUri, plugin: plugin)

        let client = PolywrapClient(clientConfigBuilder: builder)
        let wrapperUri = Uri("http/https://raw.githubusercontent.com/polywrap/wrap-test-harness/v0.2.1/wrappers/subinvoke/00-subinvoke/implementations/as")!
        struct ArgsAdd: Codable {
            var a: Int
            var b: Int
            
            public init(a: Int, b: Int) {
                self.a = a
                self.b = b
            }
        }
        let args = ArgsAdd(a: 1, b: 1)

        let result = client.invoke(uri: wrapperUri, method: "add", args: args, env: nil)
        print(result)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
