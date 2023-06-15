//
//  InjectionKey.swift
//
//
//  Created by ykkd on 2023/02/28.
//

import Foundation

// MARK: - InjectionKey
/// #Reference:
///  [Dependency Injection in Swift using latest Swift features](https://www.avanderlee.com/swift/dependency-injection/)
public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}
