//
//  File.swift
//  
//
//  Created by Ostap on 03.06.2021.
//

import SwiftUI

public extension Binding where Value: Equatable {
    func replacingNilWith<T>(_ nilValue: T) -> Binding<T> where Value == Optional<T> {
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
    
public extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        // Ensure a non-nil value in `source`.
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        // Unsafe unwrap because *we* know it's non-nil now.
        self.init(source)!
    }
}

