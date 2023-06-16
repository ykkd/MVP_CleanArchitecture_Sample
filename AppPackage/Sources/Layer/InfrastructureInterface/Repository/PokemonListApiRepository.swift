//
//  PokemonListApiRepository.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Entity

public protocol PokemonListApiRepository {
    func get(_ page: Int) async throws -> PokemonList
}
