//
//  ApiRequestable.swift
//  
//
//  Created by ykkd on 2023/06/07.
//

import Foundation

public protocol ApiRequestable {
    associatedtype Response: Decodable

    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var bodyItems: [String: Any]? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
}

extension ApiRequestable {

    public var headers: [String: String]? {
        nil
    }

    public var bodyItems: [String: Any]? {
        nil
    }

    public var cachePolicy: URLRequest.CachePolicy {
        .returnCacheDataElseLoad
    }

    public var timeoutInterval: TimeInterval {
        30
    }
}
