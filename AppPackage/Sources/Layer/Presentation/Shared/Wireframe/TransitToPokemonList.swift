//
//  File.swift
//  DaSwift
//
//  Created by yuki kanda on 2023/06/21.
//  Copyright © 2023 . All rights reserved.
//

import Foundation

public protocol TransitToPokemonList {
    @MainActor
    func pushPokemonList()
    
    @MainActor
    func presentPokemonList()
}
