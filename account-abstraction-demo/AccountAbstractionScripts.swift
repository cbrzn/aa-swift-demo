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
    var gasToken: String
    
    public init(chainId: Int, gasLimit: String, gasToken: String) {
        self.chainId = chainId
        self.gasLimit = gasLimit
        self.gasToken = gasToken
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

public struct ArgsCheckSafeIsDeployed: Codable {
    public var address = "0x38274f5828569a5f9cd4afd1266bd206d42dc3d0"
    public var connection = [
        "networkNameOrChainId": "goerli"
    ]
}

public func checkSafeIsDeployed(
    _ args: ArgsCheckSafeIsDeployed,
    _ client: PolywrapClient
) -> String {
    return client.invoke(uri: SAFE_CONTRACTS_URI, method: "getNonce", args: args, env: nil)
}

public struct ArgsSignTypedData: Codable {
    var method = "eth_signTypedData_v4"
    var params = "[\"0x61ffe691821291d02e9ba5d33098adcee71a3a17\",{\"domain\":{\"chainId\":5,\"verifyingContract\":\"0x38274f5828569a5f9cd4afd1266bd206d42dc3d0\"},\"message\":{\"baseGas\":\"0\",\"data\":\"0x6057361d0000000000000000000000000000000000000000000000000000000000000015\",\"gasPrice\":0,\"gasToken\":\"0x0000000000000000000000000000000000000000\",\"nonce\":0,\"operation\":0,\"refundReceiver\":\"0x0000000000000000000000000000000000000000\",\"safeTxGas\":0,\"to\":\"0x56535D1162011E54aa2F6B003d02Db171c17e41e\",\"value\":\"0\"},\"primaryType\":\"SafeTx\",\"types\":{\"EIP712Domain\":[{\"name\":\"chainId\",\"type\":\"uint256\"},{\"name\":\"verifyingContract\",\"type\":\"address\"}],\"SafeTx\":[{\"name\":\"to\",\"type\":\"address\"},{\"name\":\"value\",\"type\":\"uint256\"},{\"name\":\"data\",\"type\":\"bytes\"},{\"name\":\"operation\",\"type\":\"uint8\"},{\"name\":\"safeTxGas\",\"type\":\"uint256\"},{\"name\":\"baseGas\",\"type\":\"uint256\"},{\"name\":\"gasPrice\",\"type\":\"uint256\"},{\"name\":\"gasToken\",\"type\":\"address\"},{\"name\":\"refundReceiver\",\"type\":\"address\"},{\"name\":\"nonce\",\"type\":\"uint256\"}]}}]"
}

public struct ArgsRelayTransactionTEST: Codable {
    var target = "0x40A2aCCbd92BCA938b02010E17A5b8929b49130D"
    var encodedTransaction =  "0x8d80ff0a000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000004d200a6b71e26c5e0845f74c812102ca7114b6a896ab2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002041688f0b90000000000000000000000003e5c63644e683549055b9be8653de26e0b4cd36e0000000000000000000000000000000000000000000000000000000000000060b1073742015cbcf5a3a4d9d1ae33ecf619439710b89475f92e2abd2117e90f900000000000000000000000000000000000000000000000000000000000000164b63e800d0000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000140000000000000000000000000f48f2b2d2a534e402487b3ee7c18c33aec0fe5e4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000061ffe691821291d02e9ba5d33098adcee71a3a170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000038274f5828569a5f9cd4afd1266bd206d42dc3d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002246a76120200000000000000000000000056535d1162011e54aa2f6b003d02db171c17e41e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a000000000000000000000000000000000000000000000000000000000000000246057361d0000000000000000000000000000000000000000000000000000000000000015000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000041d28a9316bf7e8231f2e1b8cc7bc343f149082bb6a41473704c6d340185467a8262b572d3f348ed47a4ac4663650c0c6704f1992559805a4038f81ed722b0f20d1c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    var chainId = 5
    var options = OptionsDumb()
}

public struct OptionsDumb: Codable {
    var isSponsored = true
    var gasLimit = "350000"
}

public func relayTransactionFinally(_ args: ArgsRelayTransactionTEST, _ client: PolywrapClient) -> String {
    return client.invoke(uri: RELAY_ADAPTER_WRAPPER_URI, method: "relayTransaction", args: ["transaction": args], env: nil)
}

public func signTypedData(
    _ args: ArgsSignTypedData,
    _ client: PolywrapClient
) -> String {
    return client.invoke(uri: ETHEREUM_PROVIDER_URI, method: "request", args: args, env: nil)
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

public struct GetSafeAddressInput: Codable {
    var safeAccountConfig: AccountConfig
    var safeDeploymentConfig: DeploymentConfig
    
    public init(config: AccountConfig, salt: String?) {
        safeAccountConfig = config
        safeDeploymentConfig = DeploymentConfig(nonce: salt ?? "0x123")
    }
}

public struct ArgsGetSafeAddress: Codable {
    var input: GetSafeAddressInput
    
    public init(_ owner: String, _ salt: String?) {
        let config = AccountConfig(owners: [owner])
        self.input = GetSafeAddressInput(config: config, salt: salt ?? "0x123")
    }
}

public func getSafeAddress(
    _ args: ArgsGetSafeAddress,
    _ client: PolywrapClient
) -> String {
    return client.invoke(
        uri: SAFE_FACTORY_URI,
        method: "predictSafeAddress",
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
    var config: [String: String]
    
    public init(transaction: [String: String], options: MetaTransactionOptions) {
        self.transaction = transaction
        self.options = options
        self.config = [
            "saltNonce": "0x123"
        ]
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

func subinvoke() async -> String {
    let client = getClient(nil)
    let wrapperUri = Uri("http/https://raw.githubusercontent.com/polywrap/wrap-test-harness/v0.2.1/wrappers/asyncify/implementations/as")!
   
    struct Args:Codable {
        var numberOfTimes: Int
        
        public init(numberOfTimes: Int) {
            self.numberOfTimes = numberOfTimes
        }
    }
    let result = client.invoke(uri: wrapperUri, method: "subsequentInvokes", args: Args(numberOfTimes: 3), env: nil)
    print(result)
    return result
}
public struct ArgsGetBalanceProvider: Codable {
    var method: String
    var params: String
    
    init(address: String) {
        self.method = "eth_getBalance"
        self.params = "[\"\(address)\",\"latest\"]"
    }
}
public func getBalanceThroughClientAndMetamask(_ args: ArgsGetBalanceProvider, _ client: PolywrapClient) -> String {
    let result = client.invoke(uri: ETHEREUM_PROVIDER_URI, method: "request", args: args, env: nil)
    return result
}
