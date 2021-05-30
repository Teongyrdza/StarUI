//
//  ConditionalModifier.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

private struct Stack<Item> {
    private var items = [Item]()
    
    var currentItem: Item {
        get { items[items.count - 1] }
        set { items[items.count - 1] = newValue }
    }
    
    mutating func push(_ item: Item) {
        items.append(item)
    }
    
    @discardableResult
    mutating func pop() -> Item? {
        items.popLast()
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
private struct State {
    var view: AnyView
    var shouldPopView: Bool
    var shouldContinue: Bool
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
private var stateStack = Stack<State>()

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension View {
    func border<S: ShapeStyle>(_ content: S, if condition: Bool) -> some View {
        self
            .if(condition)
            .border(content)
            .endif()
    }
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func `if`(_ condition: Bool) -> some View {
        if condition {
            stateStack.push(State(view: self.eraseToAnyView(), shouldPopView: false, shouldContinue: false))
            return self
        }
        else {
            stateStack.push(State(view: self.eraseToAnyView(), shouldPopView: true, shouldContinue: true))
            return self
        }
    }
    
    func elif(_ condition: Bool) -> some View {
        if stateStack.currentItem.shouldContinue {
            if condition {
                stateStack.currentItem.shouldContinue = false
                stateStack.currentItem.shouldPopView = false
                return stateStack.currentItem.view
            }
            else {
                return stateStack.currentItem.view
            }
        }
        else {
            if !stateStack.currentItem.shouldPopView {
                stateStack.currentItem.view = self.eraseToAnyView()
                stateStack.currentItem.shouldPopView = true
            }
            
            return stateStack.currentItem.view
        }
    }
    
    func `else`() -> some View {
        if stateStack.currentItem.shouldContinue {
            stateStack.currentItem.shouldContinue = false
            stateStack.currentItem.shouldPopView = false
            return stateStack.currentItem.view
        }
        else {
            if !stateStack.currentItem.shouldPopView {
                stateStack.currentItem.view = self.eraseToAnyView()
                stateStack.currentItem.shouldPopView = true
            }
            
            return stateStack.currentItem.view
        }
    }
    
    func endif() -> some View {
        if stateStack.currentItem.shouldPopView {
            return stateStack.pop()!.view
        }
        else {
            stateStack.pop()
            return self
                .eraseToAnyView()
        }
    }
}

