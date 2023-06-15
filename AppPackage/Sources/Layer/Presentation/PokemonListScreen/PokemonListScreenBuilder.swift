//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import SwiftUI

public enum PokemonListScreenBuilder {

    public static func build() -> UIViewController {
        let viewData = PokemonListViewData()
        let router = PokemonListRouterImpl()
        let presenter = PokemonListPresenter(viewData: viewData, router: router)
        let screen = PokemonListScreenView(presenter: presenter, viewData: presenter.viewData)
        let vc = UIHostingController(rootView: screen)
        router.hostingController = vc
        return vc
    }
}
