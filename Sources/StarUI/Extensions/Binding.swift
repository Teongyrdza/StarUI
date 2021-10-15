//
//  File.swift
//  
//
//  Created by Ostap on 03.06.2021.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Binding where Value: Equatable {
    func replacingNilWith<T>(_ nilValue: T) -> Binding<T> where Value == T? {
        .init(self.projectedValue, replacingNilWith: nilValue)
    }
    
    init(_ source: Binding<Value?>, replacingNilWith nilValue: Value) {
        self.init(
            get: { source.wrappedValue ?? nilValue },
            set: { newValue in
                if newValue == nilValue {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
            }
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        // Ensure a non-nil value in `source`.
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        // Unsafe unwrap because we know it's non-nil now.
        self.init(source)!
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Binding {
    func forceUnwrapped<T>() -> Binding<T> where Value == T? {
        .init(
            get: { wrappedValue! },
            set: { wrappedValue = $0 }
        )
    }
}
