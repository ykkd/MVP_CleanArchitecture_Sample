//
//  GetPokemonListInteractor.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import ApplicationInterface
import Entity
import InfrastructureDependencies

public struct GetPokemonListInteractor: GetPokemonListUseCase {

    @Injected(\.pokemonListApiRepository)
    private var repository: any PokemonListApiRepository

    public init() {}

    public func execute(_ page: Int) async throws -> PokemonList {
        do {
            return try await repository.get(page)
        } catch {
            throw ApplicationError(error)
        }
    }
}
