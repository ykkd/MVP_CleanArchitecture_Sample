//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/08.
//

import Foundation

public enum ApiError: Error {
    case invalidUrl(Error?)
    case decodeError(Error)
    case clientError(Int)
    case serverError(Int)
    case invalidResponse(Error?)
}
