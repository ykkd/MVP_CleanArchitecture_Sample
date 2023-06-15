//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import Foundation
import InfrastructureInterface

public enum ApplicationError: Error {
    case network(Error)
    case unknown(Error)

    public init(_ error: Error) {
        if let error = error as? InfrastructureError {
            switch error {
            case let .api(error):
                self = .network(error)
            case let .unknown(error):
                self = .unknown(error)
            }
        } else {
            self = .unknown(error)
        }
    }
}
