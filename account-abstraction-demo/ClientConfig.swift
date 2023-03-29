//
//  ClientConfig.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 28/3/23.
//

import Foundation
import PolywrapClient
import HttpPlugin
//import MetamaskProvider

public var AA_WRAPPER_URI = Uri("wrap://wrapper/account-abstraction")!
public var ETHEREUM_CORE_WRAPPER_URI = Uri("ens/wraps.eth:ethereum@2.0.0")!
public var ETHEREUM_UTIL_WRAPPER_URI = Uri("ens/ethers.wraps.eth:utils@0.1.0")!
public var ETHEREUM_PROVIDER_URI = Uri("wrap://ens/wraps.eth:ethereum-provider@2.0.0")!
public var SAFE_MANAGER_URI = Uri("ens/safe.wraps.eth:manager@0.1.0")!
public var SAFE_FACTORY_URI = Uri("ens/safe.wraps.eth:factory@0.1.0")!
public var SAFE_CONTRACTS_URI = Uri("ens/safe.wraps.eth:contracts@0.1.0")!
public var RELAY_ADAPTER_WRAPPER_URI = Uri("wrap://ens/account-abstraction.wraps.eth:relayer-adapter@0.0.1")!
public var GELATO_RELAY_WRAPPER_URI = Uri("wrap://ens/gelato.wraps.eth:relayer@0.0.1")!

public func getClient() -> PolywrapClient {
    let builder = ConfigBuilder()
    
    let ETHEREUM_CORE_WRAPPER_HTTP_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/ethereum/core")!
    let ETHEREUM_UTIL_WRAPPER_HTTP_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/ethereum/util")!
    let AA_HTTP_WRAPPER_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/account-abstraction")!
    let SAFE_MANAGER_HTTP_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/safe/manager")!
    let SAFE_FACTORY_HTTP_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/safe/factory")!
    let SAFE_CONTRACTS_HTTP_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/safe/contracts")!
    let RELAY_ADAPTER_WRAPPER_HTTP_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/relay")!
    let GELATO_RELAY_WRAPPER_HTTP_URI = Uri("http/https://raw.githubusercontent.com/cbrzn/safe-playground/master/wrap-build-artifacts/gelato-relay")!
    
    builder.addRedirect(from: ETHEREUM_CORE_WRAPPER_URI, to: ETHEREUM_CORE_WRAPPER_HTTP_URI)
    builder.addRedirect(from: ETHEREUM_UTIL_WRAPPER_URI, to: ETHEREUM_UTIL_WRAPPER_HTTP_URI)
    builder.addRedirect(from: AA_WRAPPER_URI, to: AA_HTTP_WRAPPER_URI)
    builder.addRedirect(from: SAFE_MANAGER_URI, to: SAFE_MANAGER_HTTP_URI)
    builder.addRedirect(from: SAFE_FACTORY_URI, to: SAFE_FACTORY_HTTP_URI)
    builder.addRedirect(from: SAFE_CONTRACTS_URI, to: SAFE_CONTRACTS_HTTP_URI)
    builder.addRedirect(from: RELAY_ADAPTER_WRAPPER_URI, to: RELAY_ADAPTER_WRAPPER_HTTP_URI)
    builder.addRedirect(from: GELATO_RELAY_WRAPPER_URI, to: GELATO_RELAY_WRAPPER_HTTP_URI)

    let HTTP_RESOLVER_URI = Uri("wrap://ens/http-resolver.polywrap.eth")!
    let httpUriResolverPlugin = HttpUriResolverPlugin()
    builder.addPlugin(uri: HTTP_RESOLVER_URI, plugin: httpUriResolverPlugin)
    
    let HTTP_PLUGIN_URI = Uri("wrap://ens/http.eth")!
    let httpPlugin = HttpPlugin()
    builder.addPlugin(uri: HTTP_PLUGIN_URI, plugin: httpPlugin)
    
//    let ethereumPlugin = MetamaskProviderPlugin()
//    builder.addPlugin(uri: ETHEREUM_PROVIDER_URI, plugin: ethereumPlugin)

    
    let env: Dictionary<String, String> = [
        "safeAddress": "0x..",
        "connection": "goerli"
    ]
    
    do {
        let jsonEnv = try JSONSerialization.data(withJSONObject: env)
        builder.addEnv(uri: SAFE_MANAGER_URI, env: jsonEnv)
    } catch {
        
    }
    builder.addInterfaceImplementation(interfaceUri: ETHEREUM_PROVIDER_URI, implementationUri: ETHEREUM_PROVIDER_URI)
    
        
    return PolywrapClient(clientConfigBuilder: builder)
}
