//
//  ApiResponse.swift
//  
//
//  Created by ykkd on 2023/06/09.
//

import Foundation

public struct ApiResponse<T: Decodable> {
    public let response: T
    public let statusCode: Int
    public let responseHeaderFields: [AnyHashable: Any]?

    public init(response: T, httpURLResponse: HTTPURLResponse) {
        self.response = response
        self.statusCode = httpURLResponse.statusCode
        self.responseHeaderFields = httpURLResponse.allHeaderFields
    }
}
