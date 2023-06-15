//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Infrastructure
@_exported import InfrastructureInterface
@_exported import Dependency

// MARK: - AppEnvironmentProviderKey
struct PokemonListApiRepositoryProviderKey: InjectionKey {

    static var currentValue: any PokemonListApiRepository = PokemonListApiClient()
}

extension InjectedValues {

    public var pokemonListApiRepository: any PokemonListApiRepository {
        get { Self[PokemonListApiRepositoryProviderKey.self] }
        set { Self[PokemonListApiRepositoryProviderKey.self] = newValue }
    }
}
