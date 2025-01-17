//
//  RequestModels.swift
//  EosioSwift
//
//  Created by Farid Rahmani on 4/10/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation
import Vapor

/// Base request struct aliased by request types for `get_account`, `get_abi`, `get_raw_code_and_abi`, and `get_code` requests.
public struct EosioAccountInfo: Codable {
    public let accountName: String

    public init(accountName: String) {
        self.accountName = accountName
    }
}

/* Chain Endpoints */

/// The request struct for `get_account` RPC requests.
public typealias EosioRpcAccountRequest = EosioAccountInfo

/// The request struct for `push_transactions` RPC requests.
public struct EosioRpcPushTransactionsRequest: Codable {
    public let transactions: [EosioRpcPushTransactionRequest]
    public init(transactions: [EosioRpcPushTransactionRequest]) {
        self.transactions = transactions
    }
}

/// The request struct for `send_transactions` RPC requests.
public struct EosioRpcSendTransactionsRequest: Codable {
    public let transactions: [EosioRpcSendTransactionRequest]
    public init(transactions: [EosioRpcSendTransactionRequest]) {
        self.transactions = transactions
    }
}

/// The request type for `get_block_header_state` RPC requests.
public typealias EosioRpcBlockHeaderStateRequest = EosioRpcBlockRequest

/// The request type for `get_abi` RPC requests.
public typealias EosioRpcAbiRequest = EosioAccountInfo

/// The request struct for `get_currency_balance` RPC requests.
public struct EosioRpcCurrencyBalanceRequest: Codable {
    public var code: String
    public var account: String
    public var symbol: String?

    public init(code: String, account: String, symbol: String?) {
        self.code = code
        self.account = account
        self.symbol = symbol
    }
}

/// The request struct for `get_currency_stats` RPC requests.
public struct EosioRpcCurrencyStatsRequest: Codable {
    public var code: String
    public var symbol: String

    public init(code: String, symbol: String) {
        self.code = code
        self.symbol = symbol
    }
}

/// The request struct for `get_producers` RPC requests.
public struct EosioRpcProducersRequest: Codable {

    public var limit: UInt32?
    public var lowerBound: String
    public var json: Bool

    public init(limit: UInt32? = nil, lowerBound: String, json: Bool = true) {
        self.limit = limit
        self.lowerBound = lowerBound
        self.json = json
    }

    enum CodingKeys: String, CodingKey {
        case limit
        case lowerBound = "lower_bound"
        case json
    }
}

/// The request type for `get_raw_code_and_abi` RPC requests.
public typealias EosioRpcRawCodeAndAbiRequest = EosioAccountInfo

/// The request struct for `get_table_by_scope` RPC requests.
public struct EosioRpcTableByScopeRequest: Codable {
    public let code: String
    public let table: String?
    public let lowerBound: String?
    public let upperBound: String?
    public let limit: Int32?
    public let reverse: Bool?

    public init(code: String, table: String? = nil, lowerBound: String? = nil, upperBound: String? = nil, limit: Int32? = nil, reverse: Bool? = nil) {
        self.code = code
        self.table = table
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        self.limit = limit
        self.reverse = reverse
    }
}

/// The request struct for `get_table_rows` RPC requests.
public struct EosioRpcTableRowsRequest: Codable {
    public enum EncodeType: String, Codable {
        case dec
        case hex
    }
    public var scope: String
    public var code: String
    public var table: String
    public var tableKey: String?
    public var json: Bool
    public var lowerBound: String?
    public var upperBound: String?
    public var limit: UInt32
    public var indexPosition: String = "1"
    public var keyType: String?
    public var encodeType: EncodeType
    public var reverse: Bool?
    public var showPayer: Bool?

    public init(
        scope: String,
        code: String,
        table: String,
        json: Bool = true,
        limit: UInt32 = 10,
        tableKey: String? = nil,
        lowerBound: String? = nil,
        upperBound: String? = nil,
        indexPosition: String = "1",
        keyType: String? = nil,
        encodeType: EncodeType = .dec,
        reverse: Bool? = nil,
        showPayer: Bool? = nil
    ) {
        self.scope = scope
        self.code = code
        self.table = table
        self.tableKey = tableKey
        self.json = json
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        self.limit = limit
        self.indexPosition = indexPosition
        self.keyType = keyType
        self.encodeType = encodeType
        self.reverse = reverse
        self.showPayer = showPayer
    }

    enum CodingKeys: String, CodingKey {
        case scope
        case code
        case table
        case tableKey = "table_key"
        case json
        case lowerBound = "lower_bound"
        case upperBound = "upper_bound"
        case limit
        case indexPosition = "index_position"
        case keyType = "key_type"
        case encodeType = "encode_type"
        case reverse
        case showPayer = "show_payer"
    }
}

/// The request type for `get_kv_table_rows` RPC requests.
public struct EosioRpcKvTableRowsRequest: Codable {
    /// Encoding types for `indexValue`, `lowerBound` or `upperBound`
    public enum EncodeType: String, Codable {
        /// Arbitrary binary index values.
        case bytes
        /// String encoding
        case string
        /// Decimal encoding
        case dec
        /// Hexidecimal encoding
        case hex
        /// EosioName encoding
        case name
    }
    /// The name of the smart contract that controls the provided kv table.
    public var code: String
    /// The name of the kv table to query.
    public var table: String
    ///The name of the primary or secondary index.
    public var indexName: String
    /// The type of key specified by by the `indexName`.  This can be `bytes` for arbitrary binary index values or C++ types such as `uint64_t` or `name` for `EosioName` values.
    public var encodeType: EncodeType
    /// Should the results be deserialized and returned as json.
    public var json: Bool
    /// The value used for an exact match query, encoded as the specified `encodeType`.
    public var indexValue: String?
    /// The lower bound value for a ranged query, encoded as the specified `encodeType`.  Not used if `indexValue` is specified.  Optional if `reverse` is `true`.
    public var lowerBound: String?
    /// The upper bound value for a ranged query, encoded as the specified `encodeType`.  Not used if `indexValue is specified`.  Optional if `reverse` is `false`.
    public var upperBound: String?
    /// Limit number of results returned.
    public var limit: Int32
    /// Reverse the order of returned results.
    public var reverse: Bool?
    
    public init(
        code: String,
        table: String,
        indexName: String,
        encodeType: EncodeType = .bytes,
        json: Bool = true,
        indexValue: String? = nil,
        lowerBound: String? = nil,
        upperBound: String? = nil,
        limit: Int32 = 10,
        reverse: Bool? = nil
    ) {
        self.code = code
        self.table = table
        self.indexName = indexName
        self.encodeType = encodeType
        self.json = json
        self.indexValue = indexValue
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        self.limit = limit
        self.reverse = reverse
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case table
        case indexName = "index_name"
        case encodeType = "encode_type"
        case json
        case indexValue = "index_value"
        case lowerBound = "lower_bound"
        case upperBound = "upper_bound"
        case limit
        case reverse
    }
}

/// The request type for `get_code` RPC requests.
public struct EosioRpcCodeRequest: Codable {
    public var accountName: String
    public var codeAsWasm: Bool

    public init(accountName: String, codeAsWasm: Bool = true) {
        self.accountName = accountName
        self.codeAsWasm = codeAsWasm
    }
}

/* History Endpoints */

/// The request struct for `get_actions` RPC requests.
public struct EosioRpcHistoryActionsRequest: Codable {
    public var position: Int32?
    public var offset: Int32?
    public var accountName: String

    public init(position: Int32? = nil, offset: Int32? = nil, accountName: String) {
        self.position = position
        self.offset = offset
        self.accountName = accountName
    }

    enum CodingKeys: String, CodingKey {
        case position = "pos"
        case offset
        case accountName = "account_name"
    }
}

/// The request struct for `get_transaction_request` RPC requests.
public struct EosioRpcHistoryTransactionRequest: Codable {
    public var id: String
    public var blockNumHint: Int32?
    public init(transactionId: String, blockNumHint: Int32? = nil) {
        self.id = transactionId
        self.blockNumHint = blockNumHint
    }
}

/// The request struct for `get_key_accounts` RPC requests.
public struct EosioRpcHistoryKeyAccountsRequest: Codable {
    public var publicKey: String

    public init(publicKey: String) {
        self.publicKey = publicKey
    }
}

/// The request struct for `get_controlled_accounts` RPC requests.
public struct EosioRpcHistoryControlledAccountsRequest: Codable {
    public var controllingAccount: String

    public init(controllingAccount: String) {
        self.controllingAccount = controllingAccount
    }
}

/// The request struct for `send_transaction` RPC requests.
public struct EosioRpcSendTransactionRequest: Content {
    /// Array of signatures as Strings.
    public var signatures = [String]()
    /// Compression
    public var compression = 0
    /// Context free data, packed.
    public var packedContextFreeData = ""
    /// The serialized transaction as a hex String.
    public var packedTrx = ""
    
    enum CodingKeys: String, CodingKey {
        case signatures, compression
        case packedContextFreeData = "packed_context_free_data"
        case packedTrx = "packed_trx"
    }

    /// Initialize an `EosioRpcSendTransactionRequest`.
    public init(signatures: [String] = [], compression: Int = 0, packedContextFreeData: String = "", packedTrx: String = "") {
        self.signatures = signatures
        self.compression = compression
        self.packedContextFreeData = packedContextFreeData
        self.packedTrx = packedTrx
    }
}
