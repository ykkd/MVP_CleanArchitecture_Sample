//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Foundation
import SharedExtension

public struct Pokemon: Identifiable, Equatable, Sendable {
    public var id: Int {
        self.number
    }

    public let name: String

    public let number: Int

    public let imageUrl: URL?

    public init(_ resource: NamedUrlResource) {
        self.name = resource.name.capitalizingFirstLetter()
        self.number = PokemonNumberGenerator.generate(from: resource.url)
        self.imageUrl = PokemonImageURLGenerator.generateThumbnailURL(from: self.number)
    }
}
