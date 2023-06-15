//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/09.
//

import Foundation

enum URLRequestGenerator {

    static func generate(from request: any ApiRequestable) throws -> URLRequest {
        guard var components = URLComponents(string: request.baseUrl + request.path) else {
            throw ApiError.invalidUrl(nil)
        }
        components.queryItems = request.queryItems

        guard let url: URL = components.url else {
            throw ApiError.invalidUrl(nil)
        }

        var urlRequest = URLRequest(
            url: url,
            cachePolicy: request.cachePolicy,
            timeoutInterval: request.timeoutInterval
        )

        urlRequest.httpMethod = request.httpMethod.rawValue

        request.headers?.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        do {
            if let bodyItems = request.bodyItems {
                let httpBody = try JSONSerialization.data(withJSONObject: bodyItems, options: [])
                urlRequest.httpBody = httpBody
            }
        } catch {
            throw ApiError.invalidUrl(error)
        }

        return urlRequest
    }
}
