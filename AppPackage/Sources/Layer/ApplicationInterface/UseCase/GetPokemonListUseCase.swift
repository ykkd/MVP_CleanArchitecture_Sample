//
//  GetPokemonListUseCase.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Entity

public protocol GetPokemonListUseCase {
    func execute(_ page: Int) async throws -> PokemonList
}
