//
//  ApiWrapper.swift
//  
//
//  Created by ykkd on 2023/06/07.
//

import Foundation

public enum ApiWrapper {

    public static func request<T: ApiRequestable>(_ apiRequest: T) async throws -> ApiResponse<T.Response> {
        let urlRequest = try URLRequestGenerator.generate(from: apiRequest)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse(URLError(.badServerResponse))
        }
        switch httpURLResponse.statusCode {
        case 200 ... 299:
            return try ApiResponseDecoder.decode(data: data, response: httpURLResponse, as: apiRequest)
        case 400 ... 499:
            throw ApiError.clientError(httpURLResponse.statusCode)
        case 500 ... 599:
            throw ApiError.serverError(httpURLResponse.statusCode)
        default:
            throw ApiError.invalidResponse(URLError(.badServerResponse))
        }
    }
}
