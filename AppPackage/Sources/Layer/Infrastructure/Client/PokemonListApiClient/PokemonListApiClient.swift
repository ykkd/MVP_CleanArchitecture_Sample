//
//  PokemonListApiClient.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Entity
import InfrastructureInterface
import ApiWrapper

public struct PokemonListApiClient: PokemonListApiRepository {

    public init() {}

    public func get(_ page: Int) async throws -> PokemonList {
        do {
            let result = try await ApiWrapper.request(GetPokemonListRequest(page: page))
            let pokemons: [Pokemon] = result.response.results.map { Pokemon(NamedUrlResource(name: $0.name, url: $0.url)) }

            return PokemonList(
                count: result.response.count,
                pokemons: pokemons
            )
        } catch {
            if error is ApiError {
                throw InfrastructureError.api(error as! ApiError)
            } else {
                throw InfrastructureError.unknown(error)
            }
        }
    }
}
