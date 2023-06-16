//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import SharedPresentation
import SwiftUI

public protocol PokemonListRouter: Router {}

final class PokemonListRouterImpl: PokemonListRouter {

    weak var hostingController: UIHostingController<PokemonListScreenView>?
}
