//
//  PokemonListScreenView.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import SwiftUI
import PresentationExtension
import SharedPresentation

public struct PokemonListScreenView: View {

    var presenter: (any PokemonListPresenterInput)?
    @ObservedObject var viewData: PokemonListViewData

    public var body: some View {
        NavigationView {
            VStack {
                self.content()
                    .when(viewData.pokemons.isEmpty) { _ in
                        self.viewData.isLoading
                        ? AnyView(ProgressView())
                        : AnyView(self.emptyContent())
                    }
                    .onAppear {
                        Task { await self.presenter?.onAppear() }
                    }
                    .errorAlert(
                        error: Binding(
                            get: { self.viewData.error },
                            set: { newValue in
                                Task { await  self.presenter?.updateError(newValue) }
                            }
                        )
                    )
                Spacer()
            }
            .navigationTitle(self.viewData.title)
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    @ViewBuilder
    private func content() -> some View {
        List(self.viewData.pokemons, id: \.self.id) { pokemon in
            HStack(spacing: 16.0) {
                LoadableImage(
                    url: pokemon.imageUrl,
                    placeholder: ProgressView()
                )
                .frame(width: 48, height: 48, alignment: .center)
                Text(pokemon.name)
            }
                .onAppear {
                    if self.viewData.pokemons.last == pokemon {
                        Task { await self.presenter?.performAdditionalRequest() }
                    }
                }
        }
        .listStyle(.plain)
    }

    @ViewBuilder
    private func emptyContent() -> some View {
        Text("データがありません。")
            .multilineTextAlignment(.center)
    }
}

struct PokemonListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonListScreenView(presenter: nil, viewData: .init())
                .navigationTitle("PokeDex")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
