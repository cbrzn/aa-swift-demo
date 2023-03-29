//
//  AccountAbstractionScripts.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 29/3/23.
//

import Foundation
import PolywrapClient

public struct ArgsEncodeFunction: Codable {
    var method: String
    var args: [String]
    
    public init(method: String, args: [String]) {
        self.method = method
        self.args = args
    }
}

public func encodeFunction(_ args: ArgsEncodeFunction, _ client: PolywrapClient) -> String {
    return client.invoke(
        uri: ETHEREUM_UTIL_WRAPPER_URI,
        method: "encodeFunction",
        args: args,
        env: nil
    )
}

public struct ArgsEstimateTransactionGas: Codable {
    var to: String
    var value: String
    var data: String
    
    public init(to: String, value: String, data: String) {
        self.to = to
        self.value = value
        self.data = data
    }
}

public func estimateGas(
    _ args: ArgsEstimateTransactionGas,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: ETHEREUM_CORE_WRAPPER_URI,
        method: "estimateTransactionGas",
        args: args,
        env: nil
    )
}

public struct ArgsGetEstimateFee: Codable {
    var chainId: Int
    var gasLimit: String
    
    public init(chainId: Int, gasLimit: String) {
        self.chainId = chainId
        self.gasLimit = gasLimit
    }
}

public func getEstimateFee(
    _ args: ArgsGetEstimateFee,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: RELAY_ADAPTER_WRAPPER_URI,
        method: "getEstimateFee",
        args: args,
        env: nil
    )
}

public struct ArgsGetSafeAddress: Codable {
    var config: [String: [String: String]]
    
    public init(saltNonce: String) {
        config = [
            "config": [
                "saltNonce": saltNonce
            ]
        ]
    }
}

public func getSafeAddress(
    _ args: ArgsGetSafeAddress,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: SAFE_FACTORY_URI,
        method: "getSafeAddress",
        args: args,
        env: nil
    )
}

public struct ArgsGetBalance: Codable {
    var address: String
    var connection: [String: String?]
    
    public init(address: String, connection: String) {
        self.address = address
        self.connection = [
            "networkNameOrChainId": connection,
            "node": nil
        ]
    }
}

public func getBalance(
    _ args: ArgsGetBalance,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: ETHEREUM_CORE_WRAPPER_URI,
        method: "getBalance",
        args: args,
        env: nil
    )
}


public struct ArgsToEth: Codable {
    var wei: String
    
    public init(wei: String) {
        self.wei = wei
    }
}

public func toEth(
    _ args: ArgsGetBalance,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: ETHEREUM_CORE_WRAPPER_URI,
        method: "toEth",
        args: args,
        env: nil
    )
}

public struct MetaTransactionOptions: Codable {
    var isSponsored: Bool
    var gasLimit: String
    
    public init(isSponsored: Bool, gasLimit: String) {
        self.isSponsored = isSponsored
        self.gasLimit = gasLimit
    }
}

public struct ArgsRelayTransaction: Codable {
    var transaction: [String: String]
    var options: MetaTransactionOptions
    
    public init(transaction: [String: String], options: MetaTransactionOptions) {
        self.transaction = transaction
        self.options = options
    }
}

public func relayTransaction(
    _ args: ArgsRelayTransaction,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: AA_WRAPPER_URI,
        method: "relayTransaction",
        args: args,
        env: nil
    )
}

