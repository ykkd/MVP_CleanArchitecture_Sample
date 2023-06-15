//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Application
@_exported import ApplicationInterface
@_exported import Dependency

// MARK: - AppEnvironmentProviderKey
struct GetPokemonListUseCaseProviderKey: InjectionKey {

    static var currentValue: any GetPokemonListUseCase = GetPokemonListInteractor()
}

extension InjectedValues {

    public var getPokemonListUseCase: any GetPokemonListUseCase {
        get { Self[GetPokemonListUseCaseProviderKey.self] }
        set { Self[GetPokemonListUseCaseProviderKey.self] = newValue }
    }
}
