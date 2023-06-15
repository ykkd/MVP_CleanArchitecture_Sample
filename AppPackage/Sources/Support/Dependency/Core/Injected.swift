//
//  Injected.swift
//
//
//  Created by ykkd on 2023/03/07.
//

import Foundation

// MARK: - Injected
@propertyWrapper
public struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    public var wrappedValue: T {
        get { InjectedValues[self.keyPath] }
        set { InjectedValues[self.keyPath] = newValue }
    }

    public init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
