//
//  File.swift
//  
//
//  Created by ykkd on 2023/06/

import Foundation

extension String {

    public func capitalizingFirstLetter() -> String {
        "\(self.prefix(1).uppercased())\(self.lowercased().dropFirst())"
    }
}
