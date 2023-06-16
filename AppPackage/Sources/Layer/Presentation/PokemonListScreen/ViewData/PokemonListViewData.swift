//
//  PokemonListViewData.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import Entity
import SharedPresentation
import Foundation

public actor PokemonListViewData: ObservableObject {

    @MainActor @Published private(set) var title: String = ""
    @MainActor @Published private(set) var isLoading: Bool = false
    @MainActor @Published private(set) var pokemons: [Pokemon] = []
    @MainActor @Published private(set) var error: PresentationError?
    @MainActor @Published private(set) var isErrorShown = false
    
    @MainActor private(set) var page: Int = 1

    public init() {}

    func updateTitle(title: String) async {
        await MainActor.run {
            self.title = title
        }
    }

    func updateIsLoading(isLoading: Bool) async {
        await MainActor.run {
            self.isLoading = isLoading
        }
    }

    func updateIsErrorShown(isErorShown: Bool) async {
        await MainActor.run {
            self.isErrorShown = isErorShown
        }
    }

    func updatePokemons(pokemons: [Pokemon]) async {
        await MainActor.run {
            self.pokemons = pokemons
        }
    }

    func appendPokemons(pokemons: [Pokemon]) async {
        await MainActor.run {
            self.pokemons.append(contentsOf: pokemons)
        }
    }

    func updatePage(page: Int) async {
        await MainActor.run {
            self.page = page
        }
    }

    func updateError(_ error: PresentationError?) async {
        await MainActor.run {
            self.error = error
        }
    }
}
