//
//  Dependency.swift
//  
//
//  Created by ykkd on 2023/06/16.
//

import UIKit
import SharedPresentation
import SwiftUI
@_exported import Dependency

final private class DummyRouter: Router {
    var hostingController: UIHostingController<EmptyView>?
    
    typealias Content = EmptyView
}

// MARK: - PokemonListRouterProviderKey
struct PokemonListRouterProviderKey: InjectionKey {

    static var currentValue: () -> any Router = { DummyRouter() }
}

extension InjectedValues {

    public var pokemonListRouter: () -> any Router {
        get { Self[PokemonListRouterProviderKey.self] }
        set { Self[PokemonListRouterProviderKey.self] = newValue }
    }
}
