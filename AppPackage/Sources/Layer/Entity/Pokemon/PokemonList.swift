//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Foundation

public struct PokemonList: Sendable, Equatable {

    public let count: Int
    public let pokemons: [Pokemon]

    public init(
        count: Int,
        pokemons: [Pokemon]
    ) {
        self.count = count
        self.pokemons = pokemons
    }
}
