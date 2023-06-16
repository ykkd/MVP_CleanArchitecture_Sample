//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import ApiWrapper
import Foundation

public enum InfrastructureError: Error {
    case api(ApiError)
    case unknown(Error)
}
