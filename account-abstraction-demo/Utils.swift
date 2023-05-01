//
//  Utils.swift
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

public struct SafeAccountConfig: Codable {
    var owners: [String]
    var threshold: UInt
    
    public init(owners: [String], threshold: UInt) {
        self.owners = owners
        self.threshold = threshold
    }
}

public struct AccountConfig: Codable {
    var owners: [String]
    var threshold = 1
    public init(owners: [String]) {
        self.owners = owners
    }
}

public struct DeploymentConfig: Codable {
    var saltNonce: String
    
    public init(nonce: String) {
        self.saltNonce = nonce
    }
}

public struct SafeInput: Codable {
    var safeAccountConfig: AccountConfig
    var safeDeploymentConfig: DeploymentConfig
    
    public init(config: AccountConfig, salt: String?) {
        safeAccountConfig = config
        safeDeploymentConfig = DeploymentConfig(nonce: salt ?? "0x123")
    }
}

public struct ArgsSafe: Codable {
    var input: SafeInput
    
    public init(_ owner: String, _ salt: String?) {
        let config = AccountConfig(owners: [owner])
        self.input = SafeInput(config: config, salt: salt ?? "0x123444")
    }
}

//public func getSafeAddress(
//    _ args: ArgsSafe,
//    _ client: PolywrapClient
//) -> String {
//    return client.invoke(
//        uri: SAFE_FACTORY_URI,
//        method: "predictSafeAddress",
//        args: [
//            "input": args.input
//        ],
//        env: nil
//    )
//}

public func deploySafe(
    _ args: ArgsSafe,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: SAFE_FACTORY_URI,
        method: "deploySafe",
        args: [
            "input": args.input
        ],
        env: nil
    )
}

public struct ArgsGetBalance: Codable {
    var address: String
    
    public init(address: String) {
        self.address = address
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
