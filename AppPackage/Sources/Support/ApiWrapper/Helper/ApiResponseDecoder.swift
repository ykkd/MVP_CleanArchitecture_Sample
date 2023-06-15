//
//  ApiResponseDecoder.swift
//  
//
//  Created by ykkd on 2023/06/09.
//

import Foundation

public enum ApiResponseDecoder {

    public static func decode<T: ApiRequestable>(data: Data, response: HTTPURLResponse, as type: T) throws -> ApiResponse<T.Response> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let r = try decoder.decode(T.Response.self, from: data)
            return .init(response: r, httpURLResponse: response)
        } catch {
            throw ApiError.decodeError(error)
        }
    }
}
