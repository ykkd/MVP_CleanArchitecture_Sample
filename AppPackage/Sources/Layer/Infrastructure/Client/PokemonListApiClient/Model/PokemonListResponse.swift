//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Foundation

struct PokemonListResponse: Decodable {

    let count: Int

    let previous: String?

    let next: String?

    let results: [PokemonListResults]
}

extension PokemonListResponse {

    struct PokemonListResults: Decodable {

        let name: String

        let url: String
    }
}
