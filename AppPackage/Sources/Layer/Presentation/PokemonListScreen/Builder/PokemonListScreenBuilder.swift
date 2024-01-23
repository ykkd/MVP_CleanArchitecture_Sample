//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import PresentationDependencies
import SwiftUI

public enum PokemonListScreenBuilder {

    public static func build() -> UIViewController {
        let viewData = PokemonListViewData()
        var router = InjectedValues[\.pokemonListRouter]()
        let presenter = PokemonListPresenter(viewData: viewData, router: router as! (any PokemonListRouter))
        let screen = PokemonListScreenView(presenter: presenter, viewData: presenter.viewData)
        let vc = UIHostingController(rootView: screen)
        router.setHostingVC(vc)
        return vc
    }
}
