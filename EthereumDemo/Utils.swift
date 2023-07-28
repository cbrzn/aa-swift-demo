//
//  Utils.swift
//  EthereumDemo
//
//  Created by Cesar Brazon on 28/7/23.
//

import Foundation
import PolywrapClient

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

//public struct DeploySafeArgs: Codable {
//    public var input: ArgsSafe
//}

public func deploySafe(
    _ args: ArgsSafe,
    _ client: PolywrapClient
) throws -> String {
    return try client.invoke(
        uri: try Uri(SAFE_FACTORY_URI),
        method: "deploySafe",
        args: args,
        env: nil
    )
}
