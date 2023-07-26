//
//  ClientConfig.swift
//  EthereumDemo
//
//  Created by Cesar Brazon on 25/7/23.
//

import Foundation
import PolywrapClient

public var ETHEREUM_CORE_WRAPPER_URI = "ens/ethers.wraps.eth:0.1.0"
public var ETHEREUM_UTIL_WRAPPER_URI = "ens/ethers.wraps.eth:utils@0.1.0"
public var SAFE_MANAGER_URI = "wrap://ens/safe.wraps.eth:manager@0.1.0"
public var SAFE_FACTORY_URI = "wrap://ens/safe.wraps.eth:factory@0.1.0"
public var SAFE_CONTRACTS_URI = "wrap://ens/safe.wraps.eth:contracts@0.1.0"
public var AA_WRAPPER_URI = "wrap://ens/aa.wraps.eth:core@0.1.0"
public var RELAYER_ADAPTER_WRAPPER_URI = "wrap://ens/aa.wraps.eth:relayer-adapter@0.0.1"
public var GELATO_RELAY_WRAPPER_URI = "wrap://ens/gelato.wraps.eth:relayer@0.0.1"

public func getClient() -> PolywrapClient {
    let builder = BuilderConfig().addSystemDefault()
    
    return builder.build()
}
