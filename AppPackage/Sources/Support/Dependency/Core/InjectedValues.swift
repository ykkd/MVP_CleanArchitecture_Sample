//
//  InjectedValues.swift
//
//
//  Created by ykkd on 2023/03/07.
//

import Foundation

// MARK: - InjectedValues
/// Provides access to injected dependencies.
public struct InjectedValues {

    /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
    private static var current = InjectedValues()

    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    /// A static subscript accessor for updating and references dependencies directly.
    public static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { self.current[keyPath: keyPath] }
        set { self.current[keyPath: keyPath] = newValue }
    }
}
