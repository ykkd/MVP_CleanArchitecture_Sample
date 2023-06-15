//
//  PokemonListPresenter.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import Foundation
import ApplicationDependencies
import SharedPresentation

public protocol PokemonListPresenterInput {
    var viewData: PokemonListViewData { get }
    func onAppear() async
    func performRequest() async
    func performAdditionalRequest() async
    func updateError(_ error: PresentationError?) async
}

public final class PokemonListPresenter: PokemonListPresenterInput {

    public let viewData: PokemonListViewData

    let router: any PokemonListRouter

    @Injected(\.getPokemonListUseCase)
    var getPokemonListUseCase: any GetPokemonListUseCase

    public init(viewData: PokemonListViewData, router: any PokemonListRouter) {
        self.viewData = viewData
        self.router = router
    }

    public func onAppear() async {
        await self.viewData.updateTitle(title: "Pokedex")
        await self.performRequest()
    }

    public func performRequest() async {
        await self.viewData.updateIsLoading(isLoading: true)
        do {
            let pokemonList = try await self.getPokemonListUseCase.execute(self.viewData.page)
            await self.viewData.updatePokemons(pokemons: pokemonList.pokemons)
        } catch {
            print("e: \(error)")
        }
        await self.viewData.updateIsLoading(isLoading: false)
    }

    public func performAdditionalRequest() async {
//        await self.viewData.updateIsLoading(isLoading: true)
//        do {
//            let pokemonList = try await self.getPokemonListUseCase.execute(self.viewData.page + 1)
//            await self.viewData.updatePage(page: self.viewData.page + 1)
//            await self.viewData.appendPokemons(pokemons: pokemonList.pokemons)
//        } catch {
//            let error = PresentationError(error: .init(error), retryAction: { [weak self] in
//                await self?.performAdditionalRequest()
//            })
//            await self.viewData.updateError(error)
//        }
//        await self.viewData.updateIsLoading(isLoading: false)
        await self.viewData.updateIsLoading(isLoading: true)
        let error = PresentationError(error: .init(NSError(domain: "test", code: 0)), retryAction: { [weak self] in
            await self?.performAdditionalRequest()
        })
        await self.viewData.updateError(error)
        await self.viewData.updateIsLoading(isLoading: false)
    }

    public func updateError(_ error: PresentationError?) async {
        await self.viewData.updateError(error)
    }
}
