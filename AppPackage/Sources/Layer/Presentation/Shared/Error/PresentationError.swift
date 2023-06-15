//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import Foundation
import ApplicationInterface

/// メインスレッドから生成される想定のため、concurrencyチェックから除外
public struct PresentationError: @unchecked Sendable {
    public let value: ErrorCase
    public let retryAction: (() async -> Void)?

    public init(error: ErrorCase, retryAction: (() async -> Void)?) {
        self.value = error
        self.retryAction = retryAction
    }
}

extension PresentationError {

    public enum ErrorCase: Error {
        case network(Error)
        case unknown(Error)

        public init(_ error: Error) {
            if let error = error as? ApplicationError {
                switch error {
                case let .network(error):
                    self = .network(error)
                case let .unknown(error):
                    self = .unknown(error)
                }
            } else {
                self = .unknown(error)
            }
        }
    }
}

extension PresentationError.ErrorCase: LocalizedError {

    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .network:
            return "ネットワークエラー"
        case .unknown:
            return "不明なエラー"
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .network:
            return "時間をあけて再度お試しください"
        case .unknown:
            return nil
        }
    }
}
