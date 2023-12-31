//
//  PokemonImageURLGenerator.swift
//  
//
//  Created by ykkd on 2023/06/10.
//

import Foundation

enum PokemonImageURLGenerator {

    static func generateThumbnailURL(from id: Int) -> URL? {
        // 3桁0埋め文字列生成
        let formatId = String(format: "%03d", id)
        let imageUrl = "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/thumbnails/\(formatId).png"
        return URL(string: imageUrl)
    }

    private static func generateImageURL(from id: Int) -> URL? {
        // 3桁0埋め文字列生成
        let formatId = String(format: "%03d", id)
        let imageUrl = "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/\(formatId).png"
        return URL(string: imageUrl)
    }
}
