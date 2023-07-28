//
//  ClientConfig.swift
//  EthereumDemo
//
//  Created by Cesar Brazon on 25/7/23.
//

import Foundation
import PolywrapClient
import MetamaskProviderPlugin
import DatetimePlugin

public var ETHEREUM_CORE_WRAPPER_URI = "ens/ethers.wraps.eth:0.1.0"
public var ETHEREUM_UTIL_WRAPPER_URI = "ens/ethers.wraps.eth:utils@0.1.0"
public var SAFE_MANAGER_URI = "wrap://ens/safe.wraps.eth:manager@0.1.0"
public var SAFE_FACTORY_URI = "wrap://ens/safe.wraps.eth:factory@0.1.0"
public var SAFE_CONTRACTS_URI = "wrap://ens/safe.wraps.eth:contracts@0.1.0"
public var AA_WRAPPER_URI = "wrap://ens/aa.wraps.eth:core@0.1.0"
public var RELAYER_ADAPTER_WRAPPER_URI = "wrap://ens/aa.wraps.eth:relayer-adapter@0.0.1"
public var GELATO_RELAY_WRAPPER_URI = "wrap://ens/gelato.wraps.eth:relayer@0.0.1"

public struct RelayerEnv: Codable {
    public var relayerApiKey: String
}

public struct Connection: Codable {
    public var networkNameOrChainId: String
}

public struct SafeManagerEnv: Codable {
    public var safeAddress: String
    public var connection: Connection
}

public struct AccountAbstractionEnv: Codable {
    public var connection: Connection
}

public func getClient(_ metamaskProvider: MetamaskProvider?) throws -> PolywrapClient {
    let ETHEREUM_CORE_WRAPPER_HTTP_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/ethers/core"
    )
    let ETHEREUM_UTILS_WRAPPER_HTTP_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/ethers/utils"
    )
    let AA_HTTP_WRAPPER_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/account-abstraction/core"
    )
    let RELAY_HTTP_WRAPPER_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/account-abstraction/relay"
    )
    let SAFE_MANAGER_WRAPPER_HTTP_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/safe/manager"
    )
    let SAFE_FACTORY_WRAPPER_HTTP_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/safe/factory"
    )
    let SAFE_CONTRACTS_WRAPPER_HTTP_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/safe/core"
    )
    let GELATO_RELAY_WRAPPER_HTTP_URI = try Uri(
        "http/https://raw.githubusercontent.com/polywrap/safe-playground/main/wrap-dependencies/gelato-relayer"
    )

    let relayerEnv = RelayerEnv(relayerApiKey: "AiaCshYRyAUzTNfZZb8LftJaAl2SS3I8YwhJJXc5J7A_")
    let connection = Connection(networkNameOrChainId: "goerli")
    let safeManagerEnv = SafeManagerEnv(safeAddress: "", connection: connection)
    let accountAbstractionEnv = AccountAbstractionEnv(connection: connection)
    
    let ethereumPackage = PluginPackage(metamaskProvider!)
    let datetimePackage = PluginPackage(getDatetimePlugin())
    
    let builder = try BuilderConfig().addSystemDefault()
        .addRedirect(try Uri(ETHEREUM_CORE_WRAPPER_URI), ETHEREUM_CORE_WRAPPER_HTTP_URI)
        .addRedirect(try Uri(ETHEREUM_UTIL_WRAPPER_URI), ETHEREUM_UTILS_WRAPPER_HTTP_URI)
        .addRedirect(try Uri(AA_WRAPPER_URI), AA_HTTP_WRAPPER_URI)
        .addRedirect(try Uri(RELAYER_ADAPTER_WRAPPER_URI), RELAY_HTTP_WRAPPER_URI)
        .addRedirect(try Uri(SAFE_MANAGER_URI), SAFE_MANAGER_WRAPPER_HTTP_URI)
        .addRedirect(try Uri(SAFE_FACTORY_URI), SAFE_FACTORY_WRAPPER_HTTP_URI)
        .addRedirect(try Uri(SAFE_CONTRACTS_URI), SAFE_CONTRACTS_WRAPPER_HTTP_URI)
        .addRedirect(try Uri(GELATO_RELAY_WRAPPER_URI), GELATO_RELAY_WRAPPER_HTTP_URI)
        .addEnv(try Uri(RELAYER_ADAPTER_WRAPPER_URI), try encode(value: relayerEnv))
        .addEnv(try Uri(SAFE_MANAGER_URI), try encode(value: safeManagerEnv))
        .addEnv(try Uri(AA_WRAPPER_URI), try encode(value: accountAbstractionEnv))
        .addPackage(try Uri("wrap://ens/wraps.eth:ethereum-provider@2.0.0"), ethereumPackage)
        .addPackage(try Uri("wrap://ens/datetime.polywrap.eth"), datetimePackage)

    return builder.build()
}
