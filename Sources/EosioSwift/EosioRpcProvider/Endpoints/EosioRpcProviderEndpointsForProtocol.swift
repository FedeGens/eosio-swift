//
//  EosioRpcProviderEndpointsForProtocol.swift
//  EosioSwift
//
//  Created by Brandon Fancher on 4/22/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation
import Vapor

// MARK: - RPC methods used by `EosioTransaction`. These force conformance only to the protocols, not the entire response structs.
extension EosioRpcProvider: EosioRpcProviderProtocol {

    /// Call `chain/get_info`. This method is called by `EosioTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameter completion: Called with the response, as an `EosioResult` consisting of a response conforming to `EosioRpcInfoResponseProtocol` and an optional `EosioError`.
    public func getInfoBase(completion: @escaping (EosioResult<EosioRpcInfoResponseProtocol, EosioError>) -> Void) {
        guard let client = client else { return }
        let _ = client.get("https://wax.greymass.com/v1/chain/get_info").map { response in
            let value = try! response.content.decode(EosioRpcInfoResponse.self)
            completion(EosioResult(success: value, failure: nil)!)
        }
    }

    /// Call `chain/get_block_info`. This method is called by `EosioTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `EosioRpcBlockRequest`.
    ///   - completion: Called with the response, as an `EosioResult` consisting of a response conforming to `EosioRpcBlockResponseProtocol` and an optional `EosioError`.
    public func getBlockInfoBase(requestParameters: EosioRpcBlockInfoRequest, completion: @escaping (EosioResult<EosioRpcBlockInfoResponseProtocol, EosioError>) -> Void) {
        guard let client = client else { return }
        let _ = client.post("https://wax.greymass.com/v1/chain/get_block", beforeSend: { req in
            struct RequestStruct: Content { let block_num_or_id: UInt64 }
            
            try! req.content.encode(RequestStruct(block_num_or_id: requestParameters.blockNum))
        }).map { response in
            let value = try! response.content.decode(EosioRpcBlockInfoResponse.self)
            completion(EosioResult(success: value, failure: nil)!)
        }
    }
    
    /// Call `chain/get_raw_abi`. This method is called by `EosioTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `EosioRpcRawAbiRequest`.
    ///   - completion: Called with the response, as an `EosioResult` consisting of a response conforming to `EosioRpcRawAbiResponseProtocol` and an optional `EosioError`.
    public func getRawAbiBase(requestParameters: EosioRpcRawAbiRequest, completion: @escaping (EosioResult<EosioRpcRawAbiResponseProtocol, EosioError>) -> Void) {
        guard let client = client else { return }
        let _ = client.post("https://wax.greymass.com/v1/chain/get_raw_abi", beforeSend: { req in
            struct RequestStruct: Content { let account_name: String }
            
            try! req.content.encode(RequestStruct(account_name: requestParameters.accountName.string))
        }).map { response in
            let value = try! response.content.decode(EosioRpcRawAbiResponse.self)
            completion(EosioResult(success: value, failure: nil)!)
        }
    }

    /// Call `chain/get_required_keys`. This method is called by `EosioTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `EosioRpcRequiredKeysRequest`.
    ///   - completion: Called with the response, as an `EosioResult` consisting of a response conforming to `EosioRpcRequiredKeysResponseProtocol` and an optional `EosioError`.
    public func getRequiredKeysBase(requestParameters: EosioRpcRequiredKeysRequest, completion: @escaping (EosioResult<EosioRpcRequiredKeysResponseProtocol, EosioError>) -> Void) {
        guard let client = client else { return }
        let _ = client.post("https://wax.greymass.com/v1/chain/get_required_keys", beforeSend: { req in
            req.body = ByteBuffer.init(data: requestParameters.toJsonData())
        }).map { response in
            let value = try! response.content.decode(EosioRpcRequiredKeysResponse.self)
            completion(EosioResult(success: value, failure: nil)!)
        }
    }

    /// Call `chain/push_transaction`. This method is called by `EosioTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `EosioRpcPushTransactionRequest`.
    ///   - completion: Called with the response, as an `EosioResult` consisting of a response conforming to `EosioRpcTransactionResponseProtocol` and an optional `EosioError`.
    public func pushTransactionBase(requestParameters: EosioRpcPushTransactionRequest, completion: @escaping (EosioResult<EosioRpcTransactionResponseProtocol, EosioError>) -> Void) {
        guard let client = client else { return }
        let _ = client.post("https://wax.greymass.com/v1/chain/push_transaction", beforeSend: { req in
            try! req.content.encode(requestParameters)
        }).map { response in
            let value = try! response.content.decode(EosioRpcTransactionResponse.self)
            completion(EosioResult(success: value, failure: nil)!)
        }
    }

    /// Call `chain/send_transaction`. This method is called by `EosioTransaction`, as it only enforces the response protocol, not the entire response struct.
    ///
    /// - Parameters:
    ///   - requestParameters: An `EosioRpcSendTransactionRequest`.
    ///   - completion: Called with the response, as an `EosioResult` consisting of a response conforming to `EosioRpcTransactionResponseProtocol` and an optional `EosioError`.
    public func sendTransactionBase(requestParameters: EosioRpcSendTransactionRequest, completion: @escaping (EosioResult<EosioRpcTransactionResponseProtocol, EosioError>) -> Void) {
        guard let client = client else { return }
        let _ = client.post("https://wax.greymass.com/v1/chain/send_transaction", beforeSend: { req in
            try! req.content.encode(requestParameters)
        }).map { response in
            let value = try! response.content.decode(EosioRpcTransactionResponse.self)
            completion(EosioResult(success: value, failure: nil)!)
        }
    }
}
