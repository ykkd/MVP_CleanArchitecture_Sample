//
//  NamedUrlResource.swift
//  
//
//  Created by ykkd on 2023/06/14.
//

import Foundation

/// Common name & URL resource.
public struct NamedUrlResource {

    public let name: String

    public let url: String

    public init(
        name: String,
        url: String
    ) {
        self.name = name
        self.url = url
    }
}
