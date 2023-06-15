//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import ApiWrapper

protocol PokeApiRequestable: ApiRequestable {}

extension PokeApiRequestable {

    var baseUrl: String {
        return "https://pokeapi.co/api/v2/"
    }

    // PokeAPIでは.getしか使わないのでデフォルト実装で.getを返す
    var httpMethod: HTTPMethod {
        return .get
    }
}
