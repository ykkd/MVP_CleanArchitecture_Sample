//
//  PokemonListRouterImpl.swift
//  DaSwift
//
//  Created by yuki kanda on 2023/06/21.
//  Copyright © 2023 . All rights reserved.
//

import PokemonListScreen
import SharedPresentation
import SwiftUI

final class PokemonListRouterImpl: PokemonListRouter, TransitToPokemonList {
    var hostingController: UIHostingController<PokemonListScreenView>?
}

extension Router {
    
    func pushPokemonList() {
        let vc = PokemonListScreenBuilder.build()
        self.hostingController?.navigationController?.pushViewController(vc, animated: true)
    }

    func presentPokemonList() {
        let vc = PokemonListScreenBuilder.build()
        let nav = UINavigationController(rootViewController: vc)
        self.hostingController?.navigationController?.present(nav, animated: true)
    }
}
