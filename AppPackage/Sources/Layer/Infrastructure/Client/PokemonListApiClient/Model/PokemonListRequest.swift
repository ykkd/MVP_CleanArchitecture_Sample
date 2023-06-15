//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Foundation

struct GetPokemonListRequest: PokeApiRequestable {

    typealias Response = PokemonListResponse

    var path: String = "pokemon"

    var offset: Int = 0

    var limit: Int = 50

    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
        ]
    }

    init(page: Int) {
        self.offset = max((page - 1), 0) * self.limit
    }
}
